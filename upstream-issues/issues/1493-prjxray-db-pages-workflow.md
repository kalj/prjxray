title: prjxray-db HTML pages workflow never runs (ubuntu-18.04 runner, v2 actions)
labels: bug,ci,good first issue
upstream: 1493

The fix for this belongs in openXC7/prjxray-db, not in openXC7/prjxray.

The database HTML pages are not being built. `.github/workflows/pages.yml` in openXC7/prjxray-db still uses `runs-on: ubuntu-18.04` (line 17), `actions/checkout@v2` (line 20) and `actions/setup-python@v2` (line 30). GitHub retired the ubuntu-18.04 hosted runner, and every run on the workflow's first page (runs 6 to 30, September to November 2026) shows as cancelled. Upstream's original failure was a different one (a Travis `cp: cannot stat 'artix7_200t/*'` in `generate-html.sh`), which may come back once the job runs again.

### Suggested fix
- Move the job to `ubuntu-24.04` and current `actions/checkout` and `actions/setup-python` releases.
- Run it once with `workflow_dispatch` and fix whatever `./.github/scripts/generate-html.sh` then reports (for example missing part directories).

Imported from f4pga/prjxray#1493, opened by mithro in 2020.
