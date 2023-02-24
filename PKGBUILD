#!/bin/bash

# Disable various shellcheck rules that produce false positives in this file.
# Repository rules should be added to the .shellcheckrc file located in the
# repository root directory, see https://github.com/koalaman/shellcheck/wiki
# and https://archiv8.github.io for further information.
#
# @ToDo Add files: User documentation
# @ToDo Add files: Tooling
# @FixMe Namcap warnings and errors

# Maintainer: Ross Clark <https://github.com/Archiv8/google-chrome/discussions>
# Contributor: Ross Clark <https://github.com/Archiv8/google-chrome/discussions>

# Check for new Linux releases in: http://googlechromereleases.blogspot.com/search/label/Stable%20updates
# or use: $ curl -s https://dl.google.com/linux/chrome/rpm/stable/x86_64/repodata/other.xml.gz | gzip -df | awk -F\" "/pkgid/{ sub(".*-","",$4); print $4": "$10 }"

_channel=stable

pkgname=google-chrome
pkgver=110.0.5481.177
pkgrel=1
pkgdesc="A web browser by Google, stable)"
arch=("x86_64")
url="https://www.google.com/chrome"
license=("custom:chrome")
depends=(
  "alsa-lib"
  "gtk3"
  "libcups"
  "libxss"
  "libxtst"
  "nss"
  "ttf-liberation"
  "xdg-utils"
)
optdepends=(
  "pipewire: WebRTC desktop sharing under Wayland"
  "kdialog: for file dialogs in KDE"
  "gnome-keyring: for storing passwords in GNOME keyring"
  "kwallet: for storing passwords in KWallet"
)
options=(
  "!emptydirs"
  "!strip")
install=$pkgname.install
source=(
  "https://dl.google.com/linux/chrome/deb/pool/main/g/google-chrome-${_channel}/google-chrome-${_channel}_${pkgver}-1_amd64.deb"
  "eula_text.html"
  "google-chrome-${_channel}.sh"
)
sha512sums=(
  "cc5d64e1dae45080c42f0667e03d31b086a0fa07e54c70ed43bfae359eab4f37692fe4d25e28054f78dbab7c42e49958d27d83be76012c3ef96b1e14e271b7bc"
  "cce2729ea8d8f051ad9795225648c72bacad7eb542b454f0a7085749f6b0b31a6c5b1699d8bbc6adb2f8e67be1be04cafc2ebd31c5dec587e9d6bb1c0b62ae54"
  "7ee5eae650ab3650276de173d051039a6952afd8b041a3fc85784493e02a1e4e7deed7cffc1bb7f6d5a385d41848b7ec55e4997cc323f67ed0da4ce393bffff5"
)

package() {
  echo "  -> Extracting the data.tar.xz..."
  bsdtar -xf data.tar.xz -C "$pkgdir/"

  echo "  -> Moving stuff in place..."
  # Launcher
  install -m755 google-chrome-$_channel.sh "$pkgdir"/usr/bin/google-chrome-$_channel

  # Icons
  for i in 16x16 24x24 32x32 48x48 64x64 128x128 256x256; do
    install -Dm644 "$pkgdir"/opt/google/chrome/product_logo_${i/x*/}.png \
      "$pkgdir"/usr/share/icons/hicolor/$i/apps/google-chrome.png
  done

  # License
  install -Dm644 eula_text.html "$pkgdir"/usr/share/licenses/google-chrome/eula_text.html
  install -Dm644 "$pkgdir"/opt/google/chrome/WidevineCdm/LICENSE \
    "$pkgdir"/usr/share/licenses/google-chrome-$_channel/WidevineCdm-LICENSE.txt

  echo "  -> Fixing Chrome desktop entry..."
  sed -i \
    -e "/Exec=/i\StartupWMClass=Google-chrome" \
    -e "s/x-scheme-handler\/ftp;\?//g" \
    "$pkgdir"/usr/share/applications/google-chrome.desktop

  echo "  -> Removing Debian Cron job, duplicate product logos and menu directory..."
  rm -r \
    "$pkgdir"/etc/cron.daily/ \
    "$pkgdir"/opt/google/chrome/cron/ \
    "$pkgdir"/opt/google/chrome/product_logo_*.{png,xpm} \
    "$pkgdir"/usr/share/menu/
}
