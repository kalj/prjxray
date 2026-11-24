title: fasm2frames PUDC_B pull-up uses a fixed IOSTANDARD alias on HR banks
labels: bug,tools,needs-vivado
upstream: 1104

As of openXC7/prjxray 6dabf706, when `--emit_pudc_b_pullup` is set and the PUDC_B pin is unused, `prjxray/fasm2frames.py:294-343` adds IN_ONLY and PULLUP features to the PUDC_B IOB. For HP-bank tiles (`LIOB18`/`RIOB18`) it uses a template derived from a Vivado-built virtex7 bitstream (added in a8de0afd). For every other part it always emits the `LVCMOS25_LVCMOS33_LVTTL.IN` alias. The code comment at `fasm2frames.py:331-334` says this is known to be wrong for K70T.

Upstream found that Vivado picks LVCMOS33 on xc7a50t and xc7z010 but LVCMOS15 on xc7k70t, and the likely rule is HR bank vs HP bank. Whether the HP template is also correct for kintex7 HP banks has not been checked.

### Next steps

- For each supported package, find which bank and tile type holds PUDC_B (from `package_pins.csv` and `tilegrid.json`), and build a small Vivado design with PUDC_B unused to see which IOSTANDARD features it sets. Needs Vivado.
- Use those results to choose the template per bank type (or per part) instead of the fixed HR alias, and remove the K70T comment once confirmed.

Imported from f4pga/prjxray#1104, opened by litghost in 2019.
