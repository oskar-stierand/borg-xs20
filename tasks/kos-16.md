# KOS-16 — Arpeggiator (mode, rate, octaves, hold)

**Status:** Done (v5.5, PR #5)

## Description

Arpeggiator on top of the keyboard — generates a rhythmic sequence from held keys.

Controls:
- MODE: up / down / up-down / random
- RATE: step speed (Hz, log scale, roughly 1–20 Hz)
- OCTAVES: 1–3
- HOLD: latch — the sequence keeps running after the keys are released

Technical notes:
- Timer built on the Web Audio clock (lookahead scheduler, not setInterval)
- Calls the existing `noteOn()`/`noteOff()` based on held keys — audio engine unchanged
- UI: a new small panel section (style consistent with the LFO section)
- Arp state is stored in presets (`captureState`/`applyState`)
