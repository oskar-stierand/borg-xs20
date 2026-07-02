# 🎛️ BORG XS-20

> Webový syntezátor inspirovaný legendárním Korg MS-20. Běží přímo v prohlížeči, podporuje MIDI klávesy, single-file HTML.

![Version](https://img.shields.io/badge/version-5.1-orange)
![License](https://img.shields.io/badge/license-MIT-green)
![Audio](https://img.shields.io/badge/Web%20Audio%20API-v2-blue)

---

## ✨ Funkce

- **Analogový audio engine** — Steiner-Parker filtr, 3-stupňová saturace, termální VCO drift (pink noise ±6 centů)
- **8-hlasá parafonie** se stealingem (FIFO) a portamentem
- **Exponenciální ADSR** obálky (EG1 → filtr, EG2 → amplituda)
- **Efekty** — reverb (IR convolution), tape delay, bucket-brigade chorus
- **LFO** s modulací pitch a filtru
- **MIDI podpora** — Note On/Off s velocity, Pitch Bend, CC1 (Mod Wheel), CC7 (Volume), hot-plug
- **8 factory presetů** — CHILDREN, FUGA 1497, DREAMLAND, OXYGENE, EQUINOXE, HYPNOTIQUE, ACID SEQUENCE, PAD ATMOSPHERIQUE
- **Pitch kolo** se spring-back, **Mod kolo** perzistentní
- **Dřevěné boky** — procedurální canvas rendering
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

Tasky jsou vedeny v [Linear — BORG XS20](https://linear.app/kostohryz/project/borg-xs20-528feb2422c3).

Aktuálně otevřené:
- [x] KOS-13 — Pitch/Mod kola: realistický vizuál (guma, ridges, 3D) — *hotovo v 5.1 (PR #1)*
- [ ] KOS-14 — Dřevěné boky: fotorealistický canvas rendering
- [ ] KOS-15 — ADSR: nahradit knoby vertikálními fadery

## 📄 Licence

MIT — volně použitelné, upravitelné, šiřitelné.
