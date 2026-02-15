# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
PYTHON_COMPAT=( python3+ )
inherit cmake

DESCRIPTION="CommonMark parsing and rendering library and program in C"
HOMEPAGE="https://github.com/commonmark/cmark"
SRC_URI="https://api.github.com/repos/commonmark/cmark/tarball/refs/tags/0.31.2 -> cmark-0.31.2-eec0eeb.tar.gz"
LICENSE="NOASSERTION"
SLOT="0"
KEYWORDS="*"

post_src_unpack() {
	mv commonmark-cmark-* ${S}
}


src_configure() {
	local mycmakeargs=(
	  -DCMARK_LIB_FUZZER=OFF
	  -DBUILD_SHARED_LIBS=ON
	  -DBUILD_TESTING=OFF
	)
	cmake_src_configure
}



# vim: filetype=ebuild
