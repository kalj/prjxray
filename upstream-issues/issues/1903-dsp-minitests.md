title: Add DSP48E1 minitests
labels: enhancement,needs-vivado
upstream: 1903

As of openXC7/prjxray 6dabf706, the DSP fuzzers exist (`fuzzers/100-dsp-mskpat`, `fuzzers/100-dsp-mskpat-selpat-c`, `fuzzers/101-dsp-pips`), but `minitests/` has no DSP design. A minitest gives a Vivado bitstream that can be decoded with bit2fasm to find DSP bits the database does not yet know.

Upstream PR f4pga/prjxray#2448 (open, WIP) adds `minitests/dsp-multiplier` and `minitests/dsp-io-registers`, but it does not work as is: the Makefiles call `synth.tcl` and `impl.tcl`, which the PR does not add, and the `DSP48E1` instances leave OPMODE, ALUMODE, INMODE, clock enables and resets unconnected.

### Suggested fix
- Add a minitest that uses DSP48E1 as a plain multiplier, then one with AREG/BREG/MREG/PREG set, following an existing minitest such as `minitests/plle2_adv`, with all control inputs tied.
- Build them with Vivado, decode the bitstreams with bit2fasm and list any unknown bits in the DSP tiles. Needs Vivado.

Imported from f4pga/prjxray#1903, opened by mkurc-ant in 2022.
