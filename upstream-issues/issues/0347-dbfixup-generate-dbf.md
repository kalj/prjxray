title: Generate .dbf zero-group files automatically instead of writing them by hand
labels: enhancement,fuzzers,tools
upstream: 347

As of openXC7/prjxray 6dabf706, there are 55 hand-written `bits.dbf` / `*_bits.dbf` files under `fuzzers/` (for example `fuzzers/015-clb-nffmux/bits.dbf`, `fuzzers/030-iob/bits.dbf`). They list the bit groups that form one enum, so `utils/dbfixup.py` can add the inverted bits for the members that set no bits (`--zero-db`, `utils/dbfixup.py:720`). `dbfixup.py` only reads these files. Nothing generates them, so every new or rerun fuzzer depends on a correct hand-made group list.

Upstream proposed deriving the groups from the `.rdb` produced by segmatch, since the members of an enum are already known there.

### Suggested fix

- Write a helper that derives zero groups from a fuzzer's `.rdb` (bits shared by the tags of one enum) and emits a `.dbf`.
- Compare its output against the existing `bits.dbf` files to validate it before switching any fuzzer over. This comparison does not need Vivado.

Imported from f4pga/prjxray#347, opened by mcmasterg in 2018.
