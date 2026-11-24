title: CARRY4 ?CY0 mux has no feature for its zero-bit input; audit other muxes for the same gap
labels: enhancement,database,fuzzers
upstream: 939,940

As of openXC7/prjxray 6dabf706, the CARRY4 `?CY0` muxes are described by one tag each: `CARRY4.ACY0` / `BCY0` / `CCY0` / `DCY0` (artix7 `segbits_clblm_l.db`, for example `CLBLM_L.SLICEL_X1.CARRY4.ACY0 31_14`). `fuzzers/013-clb-ncy0/generate.py:31-32` sets the tag when the O5 input is selected ("One bit, set on O5"), so the other input (AX/BX/CX/DX, the "NX" row in `fuzzers/013-clb-ncy0/README.md`) is the all-zero state and has no feature. FASM and tools that enumerate mux inputs from the db cannot name that choice explicitly.

Upstream fixed the same gap for ADIMUX and related muxes by adding an explicit feature for the input selected when no bits are set, with inverted bits (f4pga/prjxray#900). A list of the other muxes with this gap was asked for but never made.

### Suggested fix

- Split the 013 tag into two features, for example `CARRY4.ACY0.O5` (bit set) and `CARRY4.ACY0.AX` (bit clear, as `!31_14`), via a `bits.dbf` group or a fix-up in `generate.py`, and keep the old name as an alias if downstream users (nextpnr-xilinx, fasm2frames) need it.
- Write a script that scans every `segbits_*.db` for enum-style tag groups (`<prefix>.<VALUE>`) that share bits but have no member whose bits are all inverted, and post the resulting list here.
- The audit and the db fix-up need no Vivado; regenerating 013 with the new tags does.

Imported from f4pga/prjxray#939, opened by mithro in 2019.
Imported from f4pga/prjxray#940, opened by mithro in 2019.
