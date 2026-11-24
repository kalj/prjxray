title: INT fuzzers could solve INT_L and INT_R together
labels: enhancement,fuzzers,needs-vivado
upstream: 590

As of openXC7/prjxray 6dabf706, `fuzzers/int_loop.mk` still runs segmatch separately on `segdata_int_l.txt` and `segdata_int_r.txt` and merges `int_l` and `int_r` independently. Many INT pips have identical names on both sides (for example `BYP_BOUNCE_N3_3`), or differ only by an L/R marker (`LOGIC_OUTS_L4` vs `LOGIC_OUTS4`), and have the same bits. Solving them together would roughly double the samples per pip, which could reduce iterations and false solutions.

Upstream agreed this should only happen inside the fuzzer: mangle the names before segmatch and demangle them before the db merge, so the db keeps separate L and R entries.

### Suggested fix

- Add a mangle step before segmatch and a demangle step before `mergedb` in `fuzzers/int_loop.mk`.
- Compare iteration counts and the resulting `segbits_int_[lr].db` against a normal run. Needs a Vivado fuzzer run. Performance idea, low priority.

Imported from f4pga/prjxray#590, opened by litghost in 2019.
