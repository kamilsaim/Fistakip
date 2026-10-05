# Değişiklik günlüğü

Bu proje [Semantic Versioning](https://semver.org/lang/tr/) kullanır.

---

## [1.4.1] — 2026-10-05

### Eklendi
- **Kayıtlı fişi düzenleme.** Fiş detayındaki **Düzenle** ile mağaza, tarih, tutar, kategori, ödeme, defter ve not sonradan değiştirilebilir.
- **Başka fotoğraf seç** düğmesi — yanlış fotoğraf seçilince ya da okuma başarısız olunca sayfayı yenilemeye gerek yok.
- Web sürümü için service worker (`sw.js`): internet yokken uygulama son kopyadan açılır. Ağ önce çalışır, güncellemeler gecikmez.
- Ara sekmesine **Kozmetik** kategori çipi ve **Diğer** ödeme çipi.

### Düzeltildi
- **Aramada İ harfli mağazalar bulunmuyordu** — "bim" araması "BİM"i, "istikbal" araması "İstikbal"i getirmiyordu. Arama artık Türkçe karakterlerden bağımsız.
- **Gece 00:00–03:00 arası tarih bir gün geri yazılıyordu** (UTC). Elle eklemede, okunamayan tarih yedeğinde ve yedek/Excel dosya adlarında artık yerel gün kullanılıyor.
- **Claude büyük telefon fotoğraflarında hata veriyordu** (5 MB sınırı). Gemini ve Claude'a görsel artık ~3,5 MB JPEG'e küçültülerek gidiyor.
- Claude için de geçici hatalarda (500/502/503/504/529) otomatik tekrar deneme; model bulunamadı, görsel uygun değil gibi durumlar için anlaşılır mesajlar.
- Claude model listesi güncellendi (Sonnet 5.5); eski kayıtlı model adı varsayılana çekilir.
- Özet sekmesindeyken elle eklenen ya da silinen fiş toplamlara hemen yansımıyordu.
- Yapay zekâ yanıtı doğrulanıyor: metin olarak gelen tutarlar ("1.250,00"), listede olmayan kategoriler ve bozuk tarihler düzeltiliyor.
- Eksik alanlı (ör. ürün listesi olmayan) bir kayıt, geri yüklemeden sonra bütün listeyi çökertebiliyordu; kayıtlar artık açılışta onarılıyor.
- Geri yüklemede "defter eklendi" bilgisi "bütçeler yüklendi" mesajıyla eziliyordu.
- *Düzelt* ile toplam değiştirildikten sonra çıkarılan satırlar geri alınınca elle girilen tutar kayboluyordu.
- Tutar alanı virgüllü girişi ("12,50") kabul ediyor.
- İnternet yokken Excel'e aktarma sessizce takılıyordu; artık hata mesajı veriyor. İndirilemeyen kütüphane bir sonraki denemede yeniden yükleniyor.
- Yerel OCR'da sayfa düzeni ayarı (PSM 6) Tesseract v5'te yok sayılıyordu; artık uygulanıyor. Açıklamadaki "internet gerekmez" ifadesi düzeltildi — ilk kullanımda motor ve dil paketi indirilir.
- Kategori, ödeme ve defter simgesi HTML'e kaçışsız yazılıyordu.
- Tanımsız CSS değişkenleri, fazladan `</div>`, 📊 düğmesine erişilebilir etiket.

---

## [1.4.0] — 2026-08-26 · *Ayıklama*

### Eklendi
- **Fişten ürün satırı çıkarma.** Sana ait olmayan (arkadaşına aldığın, iade ettiğin, başka deftere yazılması gereken) satırı fişten çıkarabilirsin — **tutarı fişin toplamından düşülür**, harcamana yazılmaz.
  - Ürün satırının sağındaki **✕** ile çıkarılır; satır *Çıkarılanlar* listesine düşer ve **↺** ile geri alınır. Hepsi geri alınırsa fiş ilk haline döner.
  - Hem tarama sonucunda (kaydetmeden önce) hem de kayıtlı bir fişin detay penceresinde çalışır; kayıtlı fişte değişiklik anında saklanır, listeler ve Özet tazelenir.
  - Fişin kendi toplamı korunur (`gross`) ve altta gösterilir: *Fiş toplamı ₺300,00 · 2 satır çıkarıldı −₺200,00 · kalan ₺100,00*.
  - Excel'deki *Tüm Fişler* sayfasına **Fiş Toplamı (₺)** ve **Çıkarılan (₺)** sütunları eklendi.
  - Çıkarılan satırlar fişle birlikte yedeklenir; Özet, bütçe uyarıları ve fiyat takibi kalan tutar/satırlarla çalışır.

---

## [1.3.0] — 2026-08-25 · *Defter*

### Eklendi
- **Defterler.** Kategorinin yanına ikinci bir ayrım geldi: bir fiş artık *ne aldığın* (Gıda, Kıyafet…) dışında *hangi bütçeden çıktığıyla* da işaretleniyor — **İşyeri**, **Ev** ya da kendi koyduğun isim.
  - **Fişler** sekmesinde defter süzgeci; seçili defterin fiş sayısı ve toplam tutarı başlıkta. Fiş kartlarında defter etiketi.
  - Tarama sonucunda kaydetmeden önce defter seçimi; en son kullanılan defter bir sonraki fişte önseçili gelir. Elle ekleme ve *Düzelt* formunda da alan var.
  - Kayıtlı bir fişin defteri, fişe dokununca açılan detay penceresindeki çiplerden değiştirilebilir.
  - **Ara** sekmesinde defter süzgeci; arama metni defter adında da eşleşir.
  - **Özet**'te defter dağılımı kartı (tutar ve yüzde).
  - Excel'de *Tüm Fişler* sayfasına **Defter** sütunu ve ayrı bir **Defter Özeti** sayfası.
  - Ayarlar → **Defterler**: defter ekle, adını/simgesini/rengini değiştir, sil. Ad değişince o defterdeki fişler de taşınır; defter silinince fişler silinmez, *Ayrılmamış* olur.
  - Defterler yedeğe dahil (`schema: 4`); geri yüklerken eksik defterler eklenir, var olanlar korunur.

### Düzeltildi
- Fiş kartındaki etiketler Türkçe büyük harfe çevriliyor — `Elektronik` artık `ELEKTRONIK` değil `ELEKTRONİK`.

---

## [1.2.2] — 2026-08-25

### Düzeltildi
- **Gemini okuma sırasında "Gemini hatası (503)".** 503, Google'ın "model şu an aşırı yoğun" yanıtı — kalıcı bir arıza değil, ama uygulama tek deneme yapıp pes ediyordu. Artık geçici sunucu hataları (500/502/503/504) ve kopan bağlantılar için üstel bekleyişle 4 denemeye kadar tekrar deneniyor (`Retry-After` başlığı varsa ona uyuluyor), ilerleme çubuğunda "Gemini yoğun, X sn sonra tekrar denenecek" yazıyor. Model hâlâ yoğunsa aynı anahtarın erişebildiği alternatif bir modelle bir kez daha deneniyor. Hepsi başarısız olursa ne yapılacağını söyleyen bir mesaj gösteriliyor ("birkaç dakika sonra tekrar dene veya Claude / Yerel OCR motoruna geç") — çıplak hata kodu yerine.
- Model listesi çekilirken (`Modelleri Getir` ve 404 sonrası otomatik model seçimi) oluşan geçici hatalar da artık tekrar deneniyor.
- İnternet koptuğunda çıkan `Failed to fetch` yerine "Gemini'ye ulaşılamadı. İnternet bağlantını kontrol et." gösteriliyor.

### Kaldırıldı
- **MIT lisansı.** `LICENSE` dosyası ve README'deki lisans rozeti kaldırıldı, yerine telif bildirimi kondu: kod görüntülenebilir, kullanmak için yazılı izin gerekir. Not: `v1.0.0`–`v1.2.1` etiketleri MIT altında yayınlandı, o kopyalar için verilen izin geri alınamaz.
- `yayinla.bat` ve `yayinla.sh` — tek tıkla yayınlama scriptleri

---

## [1.2.1] — 2026-07-30

### Düzeltildi
- **Ana ekran ikonu görünmüyordu.** `apple-touch-icon` bir SVG data-URI'siydi; iOS Safari SVG ana ekran ikonunu yok sayar, o yüzden *Ana Ekrana Ekle* logo yerine sayfanın ekran görüntüsünü koyuyordu. Artık `icon-512.png` gösteriliyor.

### Eklendi
- **`manifest.webmanifest`** — Android/Chrome'da "Uygulamayı yükle" artık logoyu kullanıyor, uygulama adres çubuğu olmadan (`standalone`) açılıyor, açılış zemini termal kağıt rengi.
- `mobile-web-app-capable` ve iOS durum çubuğu meta etiketleri

---

## [1.2.0] — 2026-07-30 · *Sınır*

### Eklendi
- **Kategori bütçesi.** Özet sekmesine *Aylık bütçe* geldi. Her kategori için üst sınır girilir, ayrıca tüm harcama için ortak bir sınır konabilir. Limitin %80'ine gelince satır turuncuya döner, aşılınca mali kırmızı ve **AŞILDI** damgası. Fişi kaydettiğin an ilgili limit aşıldıysa uyarır. Limitler yedeğe de girer.
- **Ürün fiyat takibi.** Aynı ürünü ikinci kez alınca *Fiyat seyri* bölümünde çıkar: birim fiyatı (satır tutarı ÷ adet), en düşük–en yüksek aralığı, ilk alıştan bugüne değişim yüzdesi ve minik fiyat eğrisi. Satıra dokununca tam geçmiş açılır — hangi tarihte, hangi mağazada, önceki alışa göre kaç lira fark. "SÜT 1 LT" ile "Süt 1lt" aynı ürün sayılır; gramaj ve adet ekleri temizlenir.
- Excel çıktısına **Ürün Fiyatları** sayfası — alış sayısı, ilk/son/en düşük/en yüksek fiyat, değişim yüzdesi.

### Düzeltildi
- Alt gezinme kapsayıcısı kapatılmamış `<div>` bırakıyordu
- Hakkında bölümündeki GitHub bağlantısı yanlış depoyu gösteriyordu
- README'deki logo ve banner yolları dosyaların gerçek konumuyla uyuşmuyordu — görseller GitHub'da görünmüyordu

---

## [1.1.0] — 2026-07-30 · *Başparmak*

### Değişti
- **Gezinme alta taşındı.** Tara / Özet / Fişler / Ara artık ekranın altında, başparmak erişiminde. Aktif sekme üstünde ince kırmızı çizgiyle işaretleniyor. iPhone ana ekran çubuğu için güvenli alan boşluğu bırakıldı.
- **Pencereler ekranın ortasında** açılıyor. Alttan kayan yaprak yerine ölçeklenerek beliren kart; sürükleme tutamacı kaldırıldı.
- Bildirimler alt menünün üstüne alındı.

### Eklendi
- **Yedeğe API anahtarı ekleme** — isteğe bağlı. Kutucuk işaretlenip onay verilirse motor ayarları ve anahtarlar yedeğe girer; dosya adına `ANAHTARLI` eklenir. Geri yüklerken ayrıca sorulur.

---

## [1.0.0] — 2026-07-30 · *Termal*

İlk kararlı sürüm. Tasarım dili, logo ve sürümleme yerine oturdu.

### Eklendi
- **Termal fiş tasarım dili** — soğuk gri-yeşil kağıt zemin, isli mürekkep, mali damga kırmızısı
- Fiş kartlarına **yırtık alt kenar**, noktalı yırtma çizgisi, monospace tutar sütunu
- Sonuç kartı için **baskı animasyonu** — sonuç kağıt besleniyormuş gibi satır satır çıkıyor
- Okuma sırasında fotoğraf üzerinde **tarama ışını**
- Özet sekmesi tek bir **kahraman fiş** oldu; toplam sıfırdan sayarak yükseliyor, dönem mali damgayla işaretleniyor
- **Logo ailesi** — ana mark, tek renk, uygulama ikonu, favicon ve iki büyük kullanım varyantı
- Ayarlara **Hakkında** bölümü: sürüm, yayın tarihi, kayıt sayısı, kapladığı yer, aktif motor
- **Karanlık mod** — cihaz ayarına göre otomatik ("karbon kopya" teması)
- `prefers-reduced-motion` desteği

### Değişti
- Emoji arayüz ikonları **SVG** ile değiştirildi (kategori emojileri korundu)
- Tipografi: Instrument Serif + DM Sans → **Bricolage Grotesque + Archivo + DM Mono**
- Tüm tutarlar **Türk para biçiminde**: `₺5.369,92`
- Arayüz metinleri sadeleşti, eylem adları tutarlı hale getirildi

### Düzeltildi
- Kısa fişlerde mağaza adına `TOPLAM` satırının karışması
- Yedek dosyasına sürüm bilgisi eklendi

---

## [0.6.0] — 2026-07-30

### Eklendi
- **Mağaza normalleştirme** — "LC WAIKIKI" ile "LC Waikiki" artık tek mağaza. 40+ Türk markası için kanonik ad tablosu, Türkçe harf duyarlı eşleştirme
- **Ödeme takibi** ayrı bir alan oldu: kredi kartı / nakit dağılımı, arama filtresi, Excel sayfası
- **Mükerrer fiş uyarısı** — aynı mağaza, tarih ve tutardaki fiş ikinci kez taranırsa sorar
- **Yedekleme** — JSON al-ver, kimlik çakışmasına karşı korumalı birleştirme
- **Geçen aya kıyas** — yüzde ve tutar farkı
- **Mağaza dağılımı** — en çok harcanan 8 mağaza
- Aramada filtrelenen fişlerin toplam tutarı
- Excel'e *Mağaza Özeti* ve *Ödeme Özeti* sayfaları

### Değişti
- Eski kayıtlar açılışta yeni alanlara otomatik taşınıyor

---

## [0.5.0] — 2026-07-30

### Eklendi
- **Gemini model keşfi** — `404` alındığında anahtarın erişebildiği modeller listelenip uygun olan seçiliyor ve kaydediliyor
- Ayarlarda **Modelleri getir** düğmesi ve elle model seçimi
- Motorlara özel hata mesajları: geçersiz anahtar, kapalı API, dolu kota, engellenen içerik

### Düzeltildi
- Sabit model adının bazı hesaplarda bulunmaması kaynaklı `404` hatası

---

## [0.4.0] — 2026-07-30

### Eklendi
- **Çoklu okuma motoru** — Yerel OCR, Gemini, Claude, OCR.space
- Motor seçimi ve anahtar girişi için **ayarlar ekranı**
- Anahtarlar **cihazın yerel hafızasında** tutuluyor; kaynak koda yazılmıyor
- Claude için model seçimi (Haiku 4.5 / Sonnet 5)
- OCR.space'in 1 MB sınırı için otomatik görüntü küçültme

---

## [0.3.0] — 2026-07-30

### Eklendi
- **Çevrimdışı OCR** — Tesseract.js ile tamamen cihaz üzerinde okuma, API anahtarı gerekmeden
- **Türk fişi ayrıştırıcısı**: `1.250,00` sayı biçimi, `TOPKDV`/`TOPLAM` ayrımı, ticari unvan temizliği, adres ve POS satırlarının elenmesi
- Görüntü ön işleme — gri tonlama, histogram gerdirme, eşikleme, 2,5× büyütme
- Ham OCR metnini görüntüleme
- Kaydetmeden düzeltme

### Değişti
- Uygulama artık anahtarsız da çalışıyor

---

## [0.2.0] — 2026-07-30

### Eklendi
- **Excel çıktısı** — Tüm Fişler, Kategori Özeti, Aylık Özet sayfaları
- Manuel fiş girişi

### Değişti
- Karanlık temadan **açık temaya** geçildi

---

## [0.1.0] — 2026-07-30

İlk çalışan sürüm.

### Eklendi
- Fiş fotoğrafından mağaza, tarih, ürün ve tutar çıkarma
- Otomatik kategori tespiti
- Özet, Fişler ve Arama sekmeleri
- 6 aylık harcama grafiği
- Verilerin cihazda saklanması
