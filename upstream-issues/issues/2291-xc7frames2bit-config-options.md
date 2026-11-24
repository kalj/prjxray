title: xc7frames2bit cannot set bitstream options such as SPI_BUSWIDTH
labels: enhancement,tools,needs-vivado
upstream: 2291

As of openXC7/prjxray 6dabf706, `tools/xc7frames2bit.cc` only takes `--part_name`, `--part_file`, `--frm_file`, `--output_file` and `--architecture` (lines 18-29). The Series7 header it writes is fixed in `lib/xilinx/configuration.cc:301` (`Configuration<Series7>::createConfigurationPackage`), and fasm2frames never sees XDC properties. So `set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]` has no effect, and Vivado reports bus width 1 when it converts these bitstreams to .mcs. Generating .mcs files directly is a separate request and is not covered here.

### Suggested fix
- Build two Vivado bitstreams that differ only in `SPI_BUSWIDTH` (1 and 4) and diff their packet streams (for example with `bitread`) to find which register writes change. Needs Vivado.
- Add an option to xc7frames2bit (for example `--spi_buswidth`) that emits those writes, and pass it through from the openXC7 flow.

Imported from f4pga/prjxray#2291, opened by maij in 2023.
