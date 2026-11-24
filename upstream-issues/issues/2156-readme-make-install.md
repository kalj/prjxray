title: README does not say how to install the C++ tools or put them on PATH
labels: documentation,good first issue
upstream: 2156

The README build steps end at `make build` (README.md Step 4, line 76). As of openXC7/prjxray 6dabf706 they never mention `make install` (Makefile:46-47) or adding `build/tools` to PATH, so users who call `xc7frames2bit` outside the prjxray environment get "No such file or directory". `utils/environment.sh:18` sets `XRAY_TOOLS_DIR` to `build/tools`, but that only helps scripts that source it. The reporter also had to edit the Makefile to run `sudo make install`: `Makefile:15-20` refuses to run as root unless `ALLOW_ROOT` is set, which the README does not say.

The pyjson5 build workaround at README.md:96-108 targets an old pyjson5 release and is probably stale (not verified).

### Suggested fix
- Add a step after `make build`: either `make install INSTALL_DIR=<prefix>` (and how to pass `ALLOW_ROOT=1` for a system-wide install), or `export PATH=$PWD/build/tools:$PATH`.
- Check the pyjson5 note against the current pyjson5 release and drop it if it no longer applies.

Imported from f4pga/prjxray#2156, opened by JamesTimothyMeech in 2023.
