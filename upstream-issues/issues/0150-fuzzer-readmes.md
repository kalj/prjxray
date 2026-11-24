title: Add a README.md to the 43 fuzzer directories that lack one
labels: documentation,fuzzers,good first issue
upstream: 150

As of openXC7/prjxray 6dabf706, 43 of the 87 directories under `fuzzers/` have no `README.md`. `docs/Makefile` (target `fuzzers-links`) only links fuzzers that have one into the Sphinx docs and prints "Missing .../README.md" for the rest, so these fuzzers are absent from the published documentation.

Missing: 000-init-db, 001-part-yaml, 007-timing, 028-fifo-config, 029-bram-fifo-config, 030-iob18-sing, 035-iob-ilogic, 035-iob18-ilogic, 035a-iob-idelay, 035a-iob18-idelay, 035a-iob18-odelay, 035b-iob-iserdes, 035b-iob18-iserdes, 036-iob-ologic, 036-iob18-ologic, 036-iob18-ologic-sing, 037-iob-pips, 037-iob18-pips, 038-cfg-startup, 039-hclk-config, 040-clk-hrow-config, 041-clk-hrow-pips, 042-clk-bufg-config, 043-clk-rebuf-pips, 048-int-piplist, 049-int-imux-gfan, 060-bram-cascades, 061-pcie-conf, 062-pcie-int-pips, 064-gtp-channel-conf, 064-gtx-channel-conf, 065-gtp-common-pips, 065b-gtp-common-pips, 066-gtp-int-pips, 071-ppips, 072-ordered_wires, 073-get_counts, 074-dump_all, 075-pins, 100-dsp-mskpat, 100-dsp-mskpat-selpat-c, 101-dsp-pips, piplist.

### Suggested fix

- For each directory, add a short `README.md`: what the fuzzer solves, which db files it writes, and its dependencies (from `fuzzers/Makefile`). Existing READMEs such as `fuzzers/033-mon-xadc/README.md` show the style.
- Can be split across several PRs. No Vivado needed.

Imported from f4pga/prjxray#150, opened by mithro in 2018.
