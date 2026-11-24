title: readFrames skips the words-per-frame check for Spartan6
labels: enhancement,tools
upstream: 1113

As of openXC7/prjxray 6dabf706, `Frames<ArchType>::readFrames()` in `lib/include/prjxray/xilinx/frames.h:151-163` checks that every frame has `ArchType::words_per_frame` words, except for Spartan6, where the check is skipped because Spartan6 IOB frames can have a different word count. A malformed Spartan6 `.frames` file is therefore accepted silently.

### Suggested fix

- Look up the expected word count per Spartan6 block type / frame address (from the part description or the frame address fields) and check against that instead of skipping.
- This needs Spartan6 bitstreams from more than one part to confirm the IOB frame sizes. Only worth doing if openXC7 keeps Spartan6 support in the bitstream tools.

Imported from f4pga/prjxray#1113, opened by tmichalak in 2019.
