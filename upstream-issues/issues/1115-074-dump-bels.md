title: 074-dump_all does not dump BELs or BEL pins into site_type_*.json
labels: enhancement,fuzzers,database,needs-vivado
upstream: 1115

As of openXC7/prjxray 6dabf706, `fuzzers/074-dump_all` writes `site_pins` and `site_pips` for each site type but no BELs and no BEL pins. In openXC7/prjxray-db, `artix7/site_type_SLICEL.json` has only the keys `site_pins`, `site_pips` and `type`. Without BELs and BEL pins, the db cannot describe routing inside a site from site pin to BEL pin.

Upstream noted that `get_bel_pins` only works on a placed BEL instance, so the dump has to place a cell on each BEL first.

### Suggested fix

- Extend the 074 Tcl to call `get_bels` and `get_bel_pins` per site type (on placed instances) and add `bels` / `bel_pins` to `site_type_*.json`.
- Needs a Vivado fuzzer run. Low value if nextpnr-xilinx keeps its own BEL data; check with its maintainers first.

Imported from f4pga/prjxray#1115, opened by litghost in 2019.
