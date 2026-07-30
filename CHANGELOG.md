# Değişiklik günlüğü

Bu proje [Semantic Versioning](https://semver.org/lang/tr/) kullanır.

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
