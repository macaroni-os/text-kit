# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="Small command-line JSON Log viewer"
HOMEPAGE="https://github.com/brocode/fblog"
SRC_URI="https://github.com/brocode/fblog/tarball/db4d6e4c85b7a721dadf467b6cbc0144918b0eb8 -> fblog-4.13.0-db4d6e4.tar.gz
https://distfiles.macaronios.org/0a/46/0d/0a460d1db6866da54ca350baa48b16970af7cc6bc499cc780a7c603a79a00a0424d8ea4fd31f42615a16a1cfcf1e48b0f03918cf89c80662ff185d07c33c627d -> fblog-4.13.0-funtoo-crates-bundle-af581006f28a2e07637b6c1803f9e9dcf78a384e3cddd1e330a2eb9296170aaacaf312f9a86bee8c3fe67816ed4eb2609fa0d622beb24be89201646b320fec2f.tar.gz"

LICENSE="Apache-2.0 Boost-1.0 BSD BSD-2 CC0-1.0 ISC LGPL-3+ MIT Apache-2.0 Unlicense WTFPL-2 ZLIB"
SLOT="0"
KEYWORDS="*"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND="virtual/rust"

DOCS=(
	README.md
	sample.json.log
	sample_context.log
	sample_nested.json.log
	sample_numbered.json.log
)

QA_FLAGS_IGNORED="/usr/bin/fblog"

src_unpack() {
	cargo_src_unpack
	rm -rf ${S}
	mv ${WORKDIR}/brocode-fblog-* ${S} || die
}