# 1) GitHub'da "fistakip" adında boş bir repo aç (README ekleme)

# 2) Dosyaları indirdiğin klasörde:
git init
git add .
git commit -m "FişTakip v1.0.0 — Termal"
git branch -M main
git remote add origin https://github.com/kamilsaim/fistakip.git
git push -u origin main

# 3) Sürümü etiketle
git tag -a v1.0.0 -m "Termal"
git push origin v1.0.0