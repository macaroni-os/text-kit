# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="Small command-line JSON Log viewer"
HOMEPAGE="https://github.com/brocode/fblog"
SRC_URI="https://github.com/brocode/fblog/tarball/c355fc82f0eca79008be1978f5facfaba55457ad -> fblog-4.12.0-c355fc8.tar.gz
https://distfiles.macaronios.org/e1/58/21/e158215d7c056c8525b790fb75e3a3a70b8f631dd9eed05ecc113bbd2bca027e6c217012629f4ddd5bb2a47723c9aaad508b8a1a673ecffde3dfb20ad269a5cc -> fblog-4.12.0-funtoo-crates-bundle-a2e530d457760a81bb48f6f0820d2d1b35b59797c86bebb8b8dd9820fbeb9bfbce2022a47835ade14f2bfb5b89875b7267630175bf1286afe32e84a8f4f2f1cf.tar.gz"

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