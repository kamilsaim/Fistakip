@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion
cd /d "%~dp0"

set REPO=https://github.com/kamilsaim/Fistakip.git
set BRANCH=main

echo.
echo   ========================================
echo     FisTakip - GitHub'a yayinla
echo   ========================================
echo.

where git >nul 2>&1
if errorlevel 1 (
  echo   [HATA] Git kurulu degil.
  echo   Indir: https://git-scm.com/download/win
  echo.
  pause & exit /b 1
)

if not exist "index.html" (
  echo   [HATA] index.html bulunamadi.
  echo   Bu dosyayi projenin bulundugu klasore koy.
  echo.
  pause & exit /b 1
)

rem --- surumu index.html icinden oku ---
set VER=
for /f "tokens=2 delims='" %%v in ('findstr /c:"version:'" index.html') do set VER=%%v
if "!VER!"=="" set VER=0.0.0
echo   Surum: v!VER!

rem --- ilk calistirma: depoyu bagla ---
if not exist ".git" (
  echo   Depo baglaniyor...
  git init -q
  git remote add origin %REPO%
  git fetch -q origin %BRANCH% 2>nul
  if not errorlevel 1 (
    rem uzaktaki gecmisi devral, dosyalara dokunma
    git reset -q --soft FETCH_HEAD
    git branch -q -M %BRANCH%
  ) else (
    git branch -q -M %BRANCH%
  )
) else (
  git remote get-url origin >nul 2>&1 || git remote add origin %REPO%
)

rem --- degisiklik var mi ---
git add -A
git diff --cached --quiet
if not errorlevel 1 (
  echo   Degisiklik yok, gonderilecek bir sey bulunamadi.
  echo.
  pause & exit /b 0
)

echo.
echo   Gonderilecek dosyalar:
git diff --cached --name-status
echo.

set MSG=
set /p MSG=  Aciklama (bos birak = "v!VER!"): 
if "!MSG!"=="" set MSG=v!VER!

git commit -q -m "!MSG!"
if errorlevel 1 ( echo   [HATA] Commit basarisiz. & pause & exit /b 1 )

echo   Gonderiliyor...
git push -u origin %BRANCH%
if errorlevel 1 (
  echo.
  echo   [HATA] Push basarisiz.
  echo   Kimlik dogrulama gerekiyorsa GitHub kullanici adin ve
  echo   sifre yerine "Personal Access Token" gir.
  echo   Token: https://github.com/settings/tokens
  echo.
  pause & exit /b 1
)

rem --- surum etiketi ---
git rev-parse "v!VER!" >nul 2>&1
if errorlevel 1 (
  git tag -a "v!VER!" -m "v!VER!"
  git push -q origin "v!VER!" 2>nul && echo   Etiket olusturuldu: v!VER!
)

echo.
echo   ========================================
echo     Tamam. Yayinda:
echo     https://kamilsaim.github.io/Fistakip/
echo   ========================================
echo.
echo   (Pages'in guncellemesi 1-2 dakika surebilir)
echo.
pause
