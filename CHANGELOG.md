# Changelog — BORG XS-20

All changes are listed newest first. The format follows [Keep a Changelog](https://keepachangelog.com/).

---

## [5.8] — 2026-07-15

### Changed
- **Repository translated to English (KOS-29)** — README, CHANGELOG, CLAUDE.md, all task files, and the one remaining Czech code comment in `index.html`; no behavior changes. New language policy: repo content in English, development conversation in Czech.

---

## [5.7] — 2026-07-09

### Changed
- **Patch cable physics (KOS-19)** — the cable no longer floats like a feather: gravity 1600 → 3200 px/s², damping 0.955 → 0.98 per substep (the cable has inertia, swings once and settles quickly), constraint solver 3 → 4 iterations (the rope doesn't stretch like a rubber band under the stronger gravity)

### Fixed
- **Dragging a cable across the keyboard triggered notes** — `setupKey()` now ignores the mouse via `window.isCableDrag()` while a cable is being held

---

## [5.6] — 2026-07-02

### Changed
- **Factory presets — arp & cable showcase (KOS-18)**:
  - **FUGA 1497** — sound preserved, now with a latched UP arp across 2 octaves (8.5 Hz) as a hypnotic bass groove, LFO breathing via the FILTER cable
  - **EMINENT 310** (replaces EQUINOXE) — lush string machine without arp: two saws detuned −6/+8 cents in 0.85 chorus, string envelope, subtle shimmer via both cables
  - **LASER HARP** — fast ping-pong arp (13 Hz, up-down) across 3 octaves with latch, patchbay intentionally empty
  - **TOCCATA** (replaces ZOOLOOK) — baroque organ: triangle + sine an octave up, Leslie chorus + church reverb, up-down arp figure, vibrato via the PITCH cable
  - **OXYGENE IV** — cable showcase: the wobble lives and dies with the FILTER cable, subtle vibrato via the PITCH cable
  - All 8 presets have an explicit `arpRate` (deterministic RATE knob when switching)

---

## [5.5] — 2026-07-02

### Added
- **Arpeggiator (KOS-16)** — an input layer between keys/MIDI and the voice engine: MODE (up/down/up-down/random), RATE (1–20 Hz, log knob, live), OCTAVES (1–3), HOLD/latch (a new chord overwrites the latch); scheduler clocked by the Web Audio clock (self-correcting, 62% gate); arp state is stored in presets; panel to the right of the keyboard

### Fixed
- **Header jumping** — the status display has a fixed width of 220 px (longer messages get clipped) and the voice counter a fixed 56 px; text changes no longer shift the layout

---

## [5.4] — 2026-07-02

### Added
- **Patch cables (KOS-17)** — first semi-modular patching: LFO OUT, PITCH 1+2 (modulates both VCOs) and FILTER IN jacks; verlet cable physics (gravity, sag, swing, settling), dragging from either end (OUT→IN and IN→OUT), magnetic snap + destination jack highlight, a dropped cable falls and fades away
- **Normalling** — the LFO→pitch/filter modulation paths only sound with a cable plugged in; the →PITCH/→FILTER knobs act as attenuators; boot has both cables plugged in (preserves previous behavior); cable state is stored in presets
- **Auto-audibility** — plugging in a cable with the attenuator at zero raises it to an audible value (→FILTER 0.35, →PITCH 0.15), knob visual included

---

## [5.3] — 2026-07-02

### Changed
- **ADSR: vertical faders instead of knobs (KOS-15)** — the 8 envelope parameters (EG1 FILTER + EG2 AMP, A/D/S/R) are now controlled by faders: recessed slot with side ticks, ivory cap matching the keyboard, colored value fill (EG1 orange, EG2 amber); drag up = increase, dblclick = reset to default; the caps side by side visually draw the envelope shape
- All other knobs (VCO, VCF, LFO, FX, MASTER, GLIDE) remain rotary
- Log scale of the time parameters (A/D/R) and preset compatibility preserved (`applyState` sets fader positions)

---

## [5.2] — 2026-07-02

### Changed
- **Wooden side panels: bog oak (KOS-14)** — dark, desaturated grey-brown palette instead of honey-orange oak; per-pixel growth rings (value noise / fBm) with a virtual pith outside the panel → cathedral arches along the board; medullary ray flecks (silvery lenses across the rings); cooler varnish and edge highlights

### Fixed
- **DPR bug in `drawWoodPanel()`** — the function read dimensions in device pixels, but the context was already scaled by `devicePixelRatio` → the texture was drawn 2× too large and got clipped; it now draws in CSS pixels

---

## [5.1] — 2026-07-02

### Changed
- **Pitch/Mod wheels: realistic projection (KOS-13)** — the ribs run parallel to the rotation axis, so they project as straight full-width stripes across the rim (the previous spherical projection made the wheels look like a "barrel"); the color marker travels with the rubber surface instead of a fixed equator position; the surface now follows the drag direction
- **Wheel rubber** — static micro-grain texture (overlay composite), specular highlight on the top edge of each rib (light from above), stronger center sheen

---

## [5.0] — 2026-07-02

### Fixed
- **FX routing** — reverb, delay, and chorus were completely disconnected (a series of connect/disconnect calls in `initAudio()` detached their inputs); new clean chain: voices → voiceBus → dry + FX sends → master → limiter
- **Presets: keyboard redraw** — `applyState()` now calls `buildKeyboard()` when the octave changes
- **Presets: LFO waveform** — `applyState()` now propagates `lfoWave` to the audio node as well
- **Knobs wiped pressed keys** — removed stray highlight clearing in `liveUpdate()`
- **MIDI pitch bend** — now applied to playing voices (shared `applyPitchBend()` with the wheel)
- **LFO memory leak** — global LFO taps are disconnected after a voice finishes (`onended` cleanup)

### Added
- **True pulse width (PWM)** — the P.WIDTH knobs generate a Fourier PeriodicWave (cached per duty); works live and from presets
- **Voice stereo width** — subtle per-voice random pan ±0.12 (analog voice-card spread)
- **Darker reverb** — one-pole lowpass over the IR with a cutoff falling along the tail

### Changed
- **Keys** — realistic ivory (multi-stage gradient, side bevels, front edge), black keys with a lacquered sheen and slanted front
- **Knobs** — knurled grip (knurl ticks), specular highlight, deeper metal gradients
- **Pitch/Mod wheels** — Retina 2× rendering

---

## [4.1-bugfix] — 2026-03-04

### Fixed
- **MIDI visual feedback** — MIDI Note On/Off now triggers the key-press visual effect (`highlight()`) just like the computer keyboard and mouse clicks
- **Keyboard octave** — `buildKeyboard()` now uses `S.octave` as the base instead of a hardcoded C3; the keyboard redraws correctly on octave change
- `allNotesOff()` now also clears the key visual highlights

---

## [4.0] — 2026-02-26

### Added
- **Steiner-Parker filter** — 2× cascaded biquad LPF with asymmetric detuning, saturation between the poles
- **3-stage saturation** — pre-filter (asymmetric tanh), resonance (soft limiter), post-filter (Chebyshev VCA)
- **Thermal VCO drift** — 8s pink noise buffer (1/f), ±6 cents, independent per oscillator and per voice
- **Sub-audio breath noise** — looped noise at −38 dB for signal liveliness
- **Exponential ADSR** — `setTargetAtTime(τ = time/3)` instead of linear ramps
- **8-voice polyphony** with stealing (FIFO), portamento preserved

### Removed
- Poly mode toggle — replaced by a static `8× ANALOG` badge (polyphony is always active)

### Changed
- All factory presets updated (removed the `polyMode` field)

---

## [3.0] — 2026-02-26

### Added
- **Wooden side panels** — procedural canvas rendering (growth rings, grain, varnish, shadows)
- Audio engine diagnosis — identified 6 key DSP problems compared to the analog MS-20

---

## [2.0] — 2026-02-26

### Added
- **Pitch/Mod wheels** — canvas cylinder renderer with perspective skew and lighting effects
- **8 factory presets** — CHILDREN, FUGA 1497, DREAMLAND, OXYGENE, EQUINOXE, HYPNOTIQUE, ACID SEQUENCE, PAD ATMOSPHERIQUE
- Project renamed to **BORG XS-20**

### Fixed
- Black key alignment on the keyboard

---

## [1.0] — 2026-02-26

### Added
- Basic Web Audio API engine — 2× VCO, VCF (HPF + LPF), VCA
- ADSR envelopes EG1 (filter) and EG2 (amplitude)
- LFO with pitch and filter modulation
- Effects: reverb (IR convolution), tape delay, bucket-brigade chorus
- Piano keyboard (3 octaves, 37 keys)
- **MIDI support** — Note On/Off with velocity, Pitch Bend (±2 semitones), CC1 Mod Wheel, CC7 Volume, hot-plug, LED indicator
- Computer keyboard support (A–K, W/E/T/Y/U, Z/X octaves)
- Rotary knobs with SVG rendering
- UI inspired by vintage MS-20 hardware
