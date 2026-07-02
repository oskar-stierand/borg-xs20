# KOS-16 — Arpeggiator (mode, rate, octaves, hold)

**Status:** Todo

## Popis

Arpeggiator nad klaviaturou — z držených kláves generuje rytmickou sekvenci.

Ovládání:
- MODE: up / down / up-down / random
- RATE: rychlost kroků (Hz, log škála, cca 1–20 Hz)
- OCTAVES: 1–3
- HOLD: latch — sekvence běží i po puštění kláves

Technicky:
- Časovač nad Web Audio clockem (lookahead scheduler, ne setInterval)
- Volá existující `noteOn()`/`noteOff()` podle držených kláves — audio engine beze změny
- UI: nová malá sekce v panelu (styl konzistentní s LFO sekcí)
- Uložit stav arpu do presetů (`captureState`/`applyState`)
