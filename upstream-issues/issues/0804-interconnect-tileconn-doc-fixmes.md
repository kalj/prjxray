title: Resolve the FIXMEs in the interconnect and tileconn docs
labels: documentation
upstream: 804,805,806

As of openXC7/prjxray 6dabf706, three FIXME warnings are still rendered in the published docs:

- `docs/dev_database/part_specific/tileconn.rst:9`: "This is a good place to add the tile wire, pip, site pin diagram." No such diagram exists.
- `docs/architecture/interconnect.rst:9` (Fake PIPs section): "Check the above is true." The paragraph claims every pip in the CLB switchbox (for example `CLBLM_L_INTER`) is fake: an always-on buffer, a LUT input permutation, or a connection between signals with the same driver.
- `docs/architecture/interconnect.rst:18` (Regular PIPs section): "Check if the above is true for PIPs outside of the INT switch box." The paragraph says each destination has a block of up to about 10 bits and each source sets a pair of bits.

For the Fake PIPs claim, the artix7 db is consistent with it: `ppips_clblm_l.db` lists all CLBLM_L pips as `always` (93) or `hint` (58).

### Suggested fix

- Add a diagram to `tileconn.rst` showing tile wires, pips, site pins, and how tileconn entries join wires of neighbouring tiles into nodes.
- Confirm the Fake PIPs paragraph against `ppips_clb*.db` for all families, check whether "hint" pips match the LUT-permutation case, and drop the FIXME.
- Check the two-bit pattern against non-INT pip segbits (for example `segbits_clk_hrow_*`, `segbits_hclk_*`, `segbits_bram_*`) and reword the Regular PIPs paragraph. No Vivado needed.

Imported from f4pga/prjxray#804, opened by mithro in 2019.
Imported from f4pga/prjxray#805, opened by mithro in 2019.
Imported from f4pga/prjxray#806, opened by mithro in 2019.
