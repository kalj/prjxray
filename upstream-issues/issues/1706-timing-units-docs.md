title: tile_type.rst gives wrong units for PIP and wire timing fields
labels: documentation,good first issue
upstream: 1706

As of openXC7/prjxray 6dabf706, `docs/dev_database/common/tile_type.rst` says delays are "in us (nanoseconds)" (lines 102 and 141), capacitance is in uF (lines 104, 135, 158) and resistance in mΩ (lines 106, 159). The first is a typo, and the other two do not fit the data. For example artix7 `INT_L.NL1END0->>NE2BEG0` has delays 0.033-0.134, `in_cap` 8.473 and `res` 1185.12. With uF and mΩ, R*C is about 10 µs, five orders of magnitude above the listed delays. The same unit set is stated in `prjxray/timing.py:84-90`.

With pF and mΩ (or fF and Ω) R*C is about 10 ps, which is plausible.

### Suggested fix
- Fix "us (nanoseconds)" to "ns", and state capacitance and resistance units that match the data, in both `tile_type.rst` and the `timing.py` docstring.
- Check the chosen units against how nextpnr-xilinx reads these fields before merging (not verified here).

Imported from f4pga/prjxray#1706, opened by gatecat in 2021.
