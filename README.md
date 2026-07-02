# 🎛️ BORG XS-20

> Webový syntezátor inspirovaný legendárním Korg MS-20. Běží přímo v prohlížeči, podporuje MIDI klávesy, single-file HTML.

![Version](https://img.shields.io/badge/version-5.5-orange)
![License](https://img.shields.io/badge/license-MIT-green)
![Audio](https://img.shields.io/badge/Web%20Audio%20API-v2-blue)

---

## ✨ Funkce

- **Analogový audio engine** — Steiner-Parker filtr, 3-stupňová saturace, termální VCO drift (pink noise ±6 centů)
- **8-hlasá parafonie** se stealingem (FIFO) a portamentem
- **Exponenciální ADSR** obálky (EG1 → filtr, EG2 → amplituda) — vertikální fadery s ivory capy
- **Efekty** — reverb (IR convolution), tape delay, bucket-brigade chorus
- **LFO** s modulací pitch a filtru — routing přes **patch kabely** (verlet fyzika, normalling à la MS-20)
- **Arpeggiator** — up/down/up-down/random, 1–20 Hz, 1–3 oktávy, HOLD latch; scheduler nad Web Audio clockem
- **MIDI podpora** — Note On/Off s velocity, Pitch Bend, CC1 (Mod Wheel), CC7 (Volume), hot-plug
- **8 factory presetů** — CHILDREN, FUGA 1497, DREAMLAND, OXYGENE, EQUINOXE, HYPNOTIQUE, ACID SEQUENCE, PAD ATMOSPHERIQUE
- **Pitch kolo** se spring-back, **Mod kolo** perzistentní
- **Dřevěné boky z bahenního dubu** — procedurální canvas rendering (per-pixel letokruhy, medullary flecks)
- **Computer keyboard** podpora (A–K = bílé klávesy, W/E/T/Y/U = černé)

## 🚀 Spuštění

Stačí otevřít `index.html` v prohlížeči. Žádné závislosti, žádný build step.

```bash
# nebo přes lokální server (doporučeno pro MIDI):
npx serve .
# → http://localhost:3000
```

> **MIDI poznámka:** Chrome/Edge vyžadují `https://` nebo `localhost` pro přístup k Web MIDI API. Při otevření přes `file://` Chrome zpravidla MIDI také povolí.

## 🎹 Ovládání

| Vstup | Akce |
|-------|------|
| Klik na klávesu | Zahrání tónu |
| A–K (keyboard) | Bílé klávesy |
| W, E, T, Y, U | Černé klávesy |
| Z / X | Oktáva dolů / nahoru |
| MIDI klávesy | Plná podpora (Note On/Off, Bend, CC) |
| Dvojklik na knob | Reset na default hodnotu |

## 🏗️ Architektura

Single-file HTML aplikace — veškerý kód (HTML, CSS, JavaScript) je v jednom souboru `index.html`. Záměrně bez frameworků ani build toolingu — maximální přenositelnost.

```
index.html
├── CSS (inline <style>)
│   ├── Layout & panel styling
│   ├── Keyboard rendering
│   └── Knob & wheel styling
└── JavaScript (inline <script>)
    ├── Audio Engine
    │   ├── VCO (2× oscilátor + drift)
    │   ├── VCF (Steiner-Parker simulation)
    │   ├── VCA + saturace
    │   └── Effects bus (reverb/delay/chorus)
    ├── Voice Manager (8-hlasá polyfonie)
    ├── MIDI Handler
    ├── UI (knobs, wheels, keyboard)
    └── Preset system
```

## 🔊 Audio Engine — technické detaily

### Steiner-Parker filtr
- 2× kaskádní biquad LPF s asymetrickým rozladěním (fc, fc×0.97)
- Saturace mezi póly pro simulaci zpětnovazební distorze
- Non-lineární Q mapping: `Q = 0.6 + (res/20)^1.6 × 17.5`

### Saturace (3 stupně)
1. **Pre-filter** — asymetrický tanh clip, kladná polovina tvrdší (sudé harmonické)
2. **Resonance** — soft limiter zabraňující self-oscillation filtru
3. **Post-filter** — Chebyshev-inspirované VCA barvení, zdůraznění 2. harmonické

### VCO Drift
- 8-sekundový pink noise buffer (1/f charakter)
- Každý hlas má ±6 centů nezávislé teplené chvění
- Připojeno na `osc1.detune` a `osc2.detune`

## 📋 Changelog

Viz [CHANGELOG.md](./CHANGELOG.md)

## 🗺️ Roadmap

Tasky jsou vedeny ve složce [`tasks/`](./tasks/) — jeden soubor na task (`kos-{číslo}.md`).

- [x] [KOS-16](./tasks/kos-16.md) — Arpeggiator (mode, rate, octaves, hold) — *v5.5*
- [x] [KOS-17](./tasks/kos-17.md) — Patch kabely MVP (LFO→filter/pitch, verlet fyzika) — *v5.4*
- [x] [KOS-15](./tasks/kos-15.md) — ADSR: vertikální fadery — *v5.3*
- [x] [KOS-14](./tasks/kos-14.md) — Dřevěné boky: bahenní dub — *v5.2*
- [x] [KOS-13](./tasks/kos-13.md) — Pitch/Mod kola: realistický vizuál — *v5.1*

## 📄 Licence

MIT — volně použitelné, upravitelné, šiřitelné.
