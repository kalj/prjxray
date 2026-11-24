title: Fuzzer 012-clb-n5ffmux refuses to run on Vivado other than 2017.2
labels: bug,fuzzers,needs-vivado
upstream: 14

As of openXC7/prjxray 6dabf706, `fuzzers/012-clb-n5ffmux/generate.sh:11` still exits with "FIXME: requires Vivado 2017.2" unless `vivado -h` reports v2017.2. openXC7 defaults to Vivado 2024.1 (`utils/environment.sh:59`, README), so `make` in `fuzzers/` fails at 012 on a default setup. The same gate was already disabled in 015-clb-nffmux and 016-clb-noutmux by b93b22de. 012 is the only fuzzer that still has it active.

Upstream, the gate was added because the MUXF8 / LUT6_2 usage in these CLB fuzzers broke on Vivado 2017.3 and later. That workaround was never merged upstream. Whether 012 now produces correct bits on 2024.1 has not been checked.

### Suggested fix

- Disable the version check at `fuzzers/012-clb-n5ffmux/generate.sh:11` the same way as in 015/016.
- Run 012 on Vivado 2024.1 for at least artix7 and diff the `*.5FFMUX.*` entries in `segbits_clbl[lm]_[lr].db` against the current prjxray-db. Needs a Vivado fuzzer run.
- If the results differ or the design fails to place, rework `fuzzers/012-clb-n5ffmux/top.py` to avoid the LUT6_2 + F7/F8 mux pattern.

Imported from f4pga/prjxray#14, opened by mcmasterg in 2017.
