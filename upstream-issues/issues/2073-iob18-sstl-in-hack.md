title: 030-iob18 adds the IOB_Y0 SSTL IN feature by hand because segmatch cannot solve it
labels: enhancement,fuzzers,needs-vivado
upstream: 2073

As of openXC7/prjxray 6dabf706, `fuzzers/030-iob18/Makefile:31-37` appends `IOB18.IOB_Y0.SSTL12_SSTL135_SSTL15.IN !38_126 39_127` to the segbits by hand, marked "TODO: This is a hack". The fuzzer solves the feature for IOB_Y1 but not for IOB_Y0. Upstream found that bit 39_127 of the Y0 feature is cleared when IOB_Y0 has a differential input, so the specimens contradict each other and segmatch returns 0 candidates.

### Suggested fix
- In `fuzzers/030-iob18/generate.py`, do not emit the Y0 `SSTL*.IN` tag (or emit it as unknown) for specimens where Y0 is part of a differential input, so the remaining specimens agree.
- Rerun 030-iob18 and remove the manual `echo` once segmatch finds the same bits. Needs a Vivado fuzzer run.

Imported from f4pga/prjxray#2073, opened by hansfbaier in 2022.
