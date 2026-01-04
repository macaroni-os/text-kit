# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
PYTHON_COMPAT=( python3+ )
inherit meson python-single-r1

DESCRIPTION="Collection of tools for building and converting documentation"
HOMEPAGE="https://wiki.gnome.org/Apps/Yelp/Tools"
SRC_URI="https://download.gnome.org/sources/yelp-tools/42/yelp-tools-42.1.tar.xz -> yelp-tools-42.1.tar.xz"
LICENSE="|| ( GPL-2+ freedist ) GPL-2+"
SLOT="0"
KEYWORDS="*"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
BDEPEND="dev-util/itstool
	virtual/pkgconfig
	
"
RDEPEND="${PYTHON_DEPS}
	$(python_gen_cond_dep 'dev-python/lxml[${PYTHON_USEDEP}]')
	dev-libs/libxml2
	dev-libs/libxslt
	gnome-extra/yelp-xsl
	
"
DEPEND="${RDEPEND}
"
pkg_setup() {
	python-single-r1_pkg_setup
}
src_install() {
	meson_src_install
	python_fix_shebang "${ED}"/usr/bin/yelp-{build,check,new}
}


# vim: filetype=ebuild
