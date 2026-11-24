title: Some PCIE_INT_INTERFACE IMUX DELAY-to-OUT pips still have no bits
labels: bug,fuzzers,database,needs-vivado
upstream: 1665

Fuzzer 062-pcie-int-pips does not solve all `IMUX_*_DELAYn -> IMUX_*_OUTn` pips of the PCIE_INT_INTERFACE tiles. Comparing `tile_type_PCIE_INT_INTERFACE_[LR].json` against `segbits_` and `ppips_pcie_int_interface_[lr].db` in openXC7/prjxray-db 0c3504f, these pips have neither bits nor a ppip entry:

- artix7 L: n = 21-31 and 40-47; artix7 R: n = 26-31 and 40-47
- kintex7 L: n = 19-31 and 40-47; kintex7 R: n = 26-31 and 40-47

Upstream reported n = 15-20 missing on L, so the solved set changes between runs. As of openXC7/prjxray 6dabf706, `fuzzers/062-pcie-int-pips/Makefile:19` still uses `N = 5` specimens.

### Suggested fix
- Raise `N` (and, if needed, bias `pcie_int_interface_pip_list.tcl` towards the unsolved pips), rerun on artix7 and kintex7, and check that the pip list above becomes empty. Needs a Vivado fuzzer run.
- If some of them turn out to have no bits, record them as ppips instead.

Imported from f4pga/prjxray#1665, opened by acomodi in 2021.
