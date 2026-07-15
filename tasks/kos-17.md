# KOS-17 — Patch cables MVP: MG→FILTER / MG→PITCH with Reason-style physics

**Status:** Done (v5.4, PR #4)

## Description

First cable patching à la the MS-20 patchbay. The MVP deliberately skips a robust routing system — 3 jacks, 2 possible cables, zero new DSP (both modulation paths already exist in the engine: `lfoGain`, `lfoFiltGain`).

### Jacks
- **MG OUT** — in the MG · LFO & FX section (source, accepts up to 2 cables)
- **FILTER IN** — in the VCF section (destination, 1 cable)
- **PITCH IN** — in the VCO·1 section (destination, 1 cable)

### Normalling (MS-20 semi-modular logic)
- Cable plugged in = modulation path active; the →FILTER / →PITCH knobs act as attenuators
- Cable unplugged = path dead (the knob does nothing), including the mod wheel on the pitch path
- **Boot: both cables plugged in** — preserves previous behavior and presets
- Cable state is stored in presets (`captureState`/`applyState`; old presets without the field = plugged in)

### Cable physics and looks (the Reason bar)
- **Verlet simulation** — a chain of ~14 points, gravity, damping, ends pinned to the jacks; the cable sags under its own weight, swings and settles after movement
- **Drag with trailing** — the free end trails and undulates behind the cursor; near a compatible jack it snaps magnetically and the jack highlights; releasing elsewhere = the cable falls and disappears
- **Rendering** — full-window canvas overlay: 3 strokes (shadow under the cable, colored body, light sheen line), metal jack plugs with a colored boot
- Cable colors from a palette (red/yellow/blue)
- Jack: metal ring with a dark hole (inner shadow), mini label

### Deliberate limitations
- No PWM over a cable — pulse width is not an AudioParam (PeriodicWave recomputation)
- No feedback loops can occur (fixed OUT→IN directions)

### Added during implementation (Oskar's feedback)
- Cables can be dragged from either end — including from an empty IN jack toward the source
- Jacks renamed: LFO OUT (instead of MG OUT), PITCH 1+2 (modulates both VCOs)
- Auto-audibility: plugging in a cable with the attenuator at zero raises the knob to an audible value (→FILTER 0.35, →PITCH 0.15)
