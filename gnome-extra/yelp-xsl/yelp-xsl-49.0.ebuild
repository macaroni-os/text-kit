# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit meson

DESCRIPTION="XSL stylesheets for yelp"
HOMEPAGE="https://gitlab.gnome.org/GNOME/yelp-xsl"
SRC_URI="https://download.gnome.org/sources/yelp-xsl/49/yelp-xsl-49.0.tar.xz -> yelp-xsl-49.0.tar.xz"
LICENSE="GPL-2+ LGPL-2.1+ MIT"
SLOT="0"
KEYWORDS="*"
BDEPEND="dev-libs/libxslt
	dev-util/itstool
	sys-devel/gettext
	virtual/pkgconfig
	
"

# vim: filetype=ebuild
