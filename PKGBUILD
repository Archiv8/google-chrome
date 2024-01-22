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
  "!strip"
  )
install=$pkgname.install
source=(
  "https://dl.google.com/linux/chrome/deb/pool/main/g/google-chrome-${_channel}/google-chrome-${_channel}_${pkgver}-1_amd64.deb"
  "eula_text.html"
  "google-chrome-${_channel}.sh"
)
sha512sums=(
  cc5d64e1dae45080c42f0667e03d31b086a0fa07e54c70ed43bfae359eab4f37692fe4d25e28054f78dbab7c42e49958d27d83be76012c3ef96b1e14e271b7bc
            ad426c19b1d97e112e9e956243f287a8fb16c5a5c53a34ad753f77d88167a46c277979d5f2d4d52b4de0d74d72cc39186130762d8847cb48b861d43e5c05ae04
            6ea97a290b71acf0966834b5776bedf9a2d3165a07833d2679b6a9513ee4149b42f95f4ff5ca9c06db8b215bab340803e22451c4482ee9453b325fcb30987fc4
)

package() {
	bsdtar -xf data.tar.xz -C "$pkgdir/"

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

	# Fix the Chrome desktop entry
	sed -i \
		-e "/Exec=/i\StartupWMClass=Google-chrome" \
		-e "s/x-scheme-handler\/ftp;\?//g" \
		"$pkgdir"/usr/share/applications/google-chrome.desktop

	# Remove the Debian Cron job, duplicate product logos and menu directory
	rm -r \
		"$pkgdir"/etc/cron.daily/ \
		"$pkgdir"/opt/google/chrome/cron/ \
		"$pkgdir"/opt/google/chrome/product_logo_*.{png,xpm} \
		"$pkgdir"/usr/share/menu/
}
