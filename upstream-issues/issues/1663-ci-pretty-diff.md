title: CI never produces diff.html: diff2html is not installed
labels: bug,ci,good first issue
upstream: 1663

As of openXC7/prjxray 6dabf706, `.github/scripts/db.sh:158` and `:164` call `diff2html` to write `diff.html` and `diff.json`, and `.github/workflows/Pipeline.yml:89-90` uploads both as artifacts. The Install step (`Pipeline.yml:38-61`) never installs Node.js or `diff2html-cli`, and both calls are wrapped in `set +e` and `|| true`, so the step fails silently and the files are never produced. Upstream the tool was installed but crashed on an old Node.js; here it is simply missing.

### Suggested fix
- Install Node.js and `diff2html-cli` in the BuildDatabase Install step (or use a pinned `npx diff2html-cli` call), then check that `diff.html` shows up in the uploaded artifact.
- Or drop the step and the two artifact paths if nobody uses the HTML diff.

Imported from f4pga/prjxray#1663, opened by mithro in 2021.
