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
pkgver=110.0.5481.177-1
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
  "80e4ed357e9a117e00f0a4d2531369990ad6ea542a65c21808ebb6f31bca7fda801c02a300c3afc8df12f97c424167f50a8520e5792759eb670e7b0041358cc1"
  "c733a940fd26329f5b68a55f7470eef1e0ea25e7d87e238082c397370cbfd5fe585b385c51d33f76fb60b702f1a0f4badfe49dfc72b9ef60dd4459b7c858e516"
  "05183afeb38436b76c577b6dca03b4b7a357e7de890c076ce0110e0a126436887872935e266b07385f71e39879a350b87fe86cccadd70e298c78ae22b2088aca"
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
