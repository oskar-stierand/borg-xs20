# KOS-29 — Translate the repository to English

**Status:** Done (v5.8, PR #8)

## Description

The public repo should be entirely in English; development communication with Oskar stays in Czech. Same approach as KOS-28 in the sister project BORG XR-09.

Scope:
- Translate README.md, CHANGELOG.md, and CLAUDE.md to English
- Translate all task files in `tasks/` (kos-13 through kos-19) and `versions/README.md`
- Translate the one remaining Czech code comment in `index.html` (comment only — no behavior changes)
- Add a language policy section to CLAUDE.md: repo content in English, conversation in Czech
- Going forward, new task files and changelog entries are written in English

Technical notes:
- The instrument UI was already in English (VCO, VCF, ARPEGGIATOR, …) — no UI changes
- Commit messages were already in English by convention
- Task numbering: kos-20 through kos-28 belong to the XR-09 project, hence kos-29
