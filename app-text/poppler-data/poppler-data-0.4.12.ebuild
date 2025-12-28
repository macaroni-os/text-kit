# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7

DESCRIPTION="Data files for poppler to support uncommon encodings without xpdfrc"
HOMEPAGE="https://poppler.freedesktop.org/"
SRC_URI="https://poppler.freedesktop.org/poppler-data-0.4.12.tar.gz -> poppler-data-0.4.12.tar.gz"
LICENSE="BSD GPL-2 MIT"
SLOT="0"
KEYWORDS="*"
src_install() {
	emake prefix=/usr DESTDIR="${D}" install
	dodir /usr/share/poppler/cMaps
	cd "${D}"/usr/share/poppler/cMaps || die
	find ../cMap -type f -exec ln -s {} . \; || die
}


# vim: filetype=ebuild
