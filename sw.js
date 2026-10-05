/* FişTakip — çevrimdışı açılış için service worker.
   Ağ önce: internet varsa her zaman en güncel sürüm gelir, yoksa son kopya önbellekten açılır.
   API çağrıları (Gemini, Claude, OCR.space) ve Tesseract dil paketleri önbelleğe alınmaz. */
const CACHE='fistakip-v1';
const SHELL=['./','./index.html','./manifest.webmanifest','./icon-512.png','./app-icon.svg'];
const CACHEABLE_HOSTS=['fonts.googleapis.com','fonts.gstatic.com','cdnjs.cloudflare.com'];

self.addEventListener('install',e=>{
  e.waitUntil(caches.open(CACHE).then(c=>c.addAll(SHELL)).then(()=>self.skipWaiting()));
});

self.addEventListener('activate',e=>{
  e.waitUntil(
    caches.keys().then(keys=>Promise.all(keys.filter(k=>k!==CACHE).map(k=>caches.delete(k))))
      .then(()=>self.clients.claim())
  );
});

self.addEventListener('fetch',e=>{
  const req=e.request;
  if(req.method!=='GET')return;
  const url=new URL(req.url);
  const same=url.origin===self.location.origin;
  if(!same&&!CACHEABLE_HOSTS.includes(url.hostname))return;

  e.respondWith(
    fetch(req).then(res=>{
      if(res&&(res.ok||res.type==='opaque')){
        const copy=res.clone();
        caches.open(CACHE).then(c=>c.put(req,copy));
      }
      return res;
    }).catch(()=>caches.match(req,{ignoreSearch:same}).then(hit=>
      hit||(req.mode==='navigate'?caches.match('./index.html'):Response.error())
    ))
  );
});
