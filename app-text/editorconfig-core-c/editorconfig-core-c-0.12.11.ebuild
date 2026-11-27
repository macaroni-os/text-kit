# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit cmake

DESCRIPTION="EditorConfig core library written in C"
HOMEPAGE="https://editorconfig.org/"
SRC_URI="https://api.github.com/repos/editorconfig/editorconfig-core-c/tarball/refs/tags/v0.12.11 -> editorconfig-core-c-0.12.11-0ba157e.tar.gz"
LICENSE="BSD-2"
SLOT="0"
KEYWORDS="*"
IUSE="cli doc"
BDEPEND="doc? ( app-doc/doxygen )
	
"
RDEPEND="dev-libs/libpcre2
	cli? ( !dev-python/editorconfig-core-py[cli] )
	
"
DEPEND="${RDEPEND}
"

post_src_unpack() {
	mv editorconfig-editorconfig-core-c-* ${S}
}


src_prepare() {
	# Serialise the build (the tree ebuild did the same) and make the
	# shared library use the name the CLI expects.
	export MAKEOPTS="-j1"
	sed -e 's:OUTPUT_NAME editorconfig_static:OUTPUT_NAME editorconfig:' \
	  -i src/lib/CMakeLists.txt || die
	cmake_src_prepare
}
src_configure() {
	local mycmakeargs=(
	  -DBUILD_TESTING=OFF
	  -DINSTALL_HTML_DOC=$(usex doc ON OFF)
	)
	cmake_src_configure
}
src_install() {
	cmake_src_install
	use cli || rm -rf "${ED}/usr/bin"
}



# vim: filetype=ebuild
