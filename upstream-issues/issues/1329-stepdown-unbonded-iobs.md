title: fasm2frames does not set STEPDOWN on unbonded IOB33 sites of a bank
labels: bug,tools
upstream: 1329

When one IOB in a bank uses a STEPDOWN feature, fasm2frames copies it to the other IOBs of that bank. As of openXC7/prjxray 6dabf706 the bank's tile list still comes only from `package_pins.csv` (`prjxray/fasm2frames.py:245-248`), plus the HCLK_IOI3/HCLK_IOI anchor tile from `part.json` (`prjxray/fasm2frames.py:233-243`). `package_pins.csv` lists bonded pins only, so the walk at `prjxray/fasm2frames.py:383-400` never reaches unbonded IOB33 sites. Vivado sets STEPDOWN for the whole bank, bonded or not, so the bitstream differs from Vivado's.

### Suggested fix
- Build each bank's IOB33 tile list from the tilegrid instead of the package: for example all LIOB33/RIOB33 tiles in the same IO column within the rows served by the bank's HCLK_IOI3 anchor.
- Check the result against a Vivado bitstream of a design that uses a STEPDOWN standard on a package with unbonded pins (an existing harness bitstream may be enough; not checked).

Imported from f4pga/prjxray#1329, opened by mkurc-ant in 2020.
