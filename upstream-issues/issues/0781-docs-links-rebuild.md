title: Docs build recreates every fuzzer/minitest link on each rebuild
labels: documentation,enhancement,good first issue
upstream: 781

As of openXC7/prjxray 6dabf706, `docs/conf.py:153` runs `make links` on every Sphinx build. The `fuzzers-links` and `minitests-links` targets in `docs/Makefile` first delete all existing `.md` links in `docs/db_dev_process/fuzzers` and `docs/db_dev_process/minitests`, then recreate every symlink. With `make livehtml`, each rebuild touches all the linked READMEs, so sphinx-autobuild treats them as changed and rebuilds the whole site. This makes live preview slow.

### Suggested fix

- In `docs/Makefile`, create only the links that are missing (`[ -e $${n}.md ] || ln -s ...`) and remove only stale links, instead of deleting all of them first.
- Optionally skip `make links` in `conf.py` when the link directories are already up to date. No Vivado needed.

Imported from f4pga/prjxray#781, opened by mgielda in 2019.
