# KOS-31 — README hero screenshot

**Status:** Done (docs, PR #9)

## Description

Add a single preview image to the README, placed right under the app title (no gallery — one image is enough). The shot should always capture a nice patch or preset.

## Solution

- `docs/screenshots/borg-xs20.png` — the OXYGENE IV factory preset with both LFO cables plugged (PITCH + FILTER sweeping across the panel), a clean "nice patch" hero shot
- Embedded in README.md directly below the `# BORG XS-20` title
- Reproducible capture: headless Chrome (`--headless=new`, `--force-device-scale-factor=1`, `--virtual-time-budget` to let the verlet cables settle) loading the app with the preset encoded in the `?patch=` URL, then cropped to the `.synth-frame` element with `sips`
- The header MIDI status was neutralized to "NO MIDI" (instead of the headless "DENIED") via a temporary MIDI-API stub in a scratchpad copy — the committed `index.html` is untouched

## Notes for future screenshots

- Same recipe works for any preset: load it in the running app, grab `btoa(JSON.stringify(captureState()))`, feed it to the `?patch=` URL, headless-screenshot, crop to `.synth-frame` (at window 1800×952 the frame is x=180 y=24, 1440×497)
