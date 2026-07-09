# CLAUDE.md — Instrukce pro Claude Code

Tento soubor popisuje jak pracovat s projektem BORG XS-20. Přečti ho vždy před jakoukoliv změnou kódu.

---

## Projekt

**BORG XS-20** je single-file webový syntezátor v `index.html`. Žádný build, žádné závislosti, žádný Node.js — vše je v jednom souboru.

Tasky jsou vedeny ve složce **`tasks/`** — jeden soubor na task, pojmenovaný `kos-{číslo}.md` (např. `tasks/kos-16.md`). Linear zatím nepoužíváme; formát je ale Linear-importovatelný (H1 = titulek s ID, **Status:** Todo/In Progress/Done, sekce Popis) a Oskar je tam později hromadně nahraje — strukturu neměnit.  
Před každou prací načti soubory se statusem `Todo` z `tasks/`.

---

## Zásady práce s kódem

### ✅ Vždy
- **Chirurgické změny** — měň jen to co je v tasku. Jeden task = jedna izolovaná změna.
- **Syntax check** po každé změně: `node -e "new Function(js)"` na JS blok
- **Záloha před změnou** — zkopíruj aktuální `index.html` do `versions/index-vX.html`
- **Changelog** — před mergem PR přidej do `CHANGELOG.md` sekci `## [X.Y] — YYYY-MM-DD` (podsekce Přidáno/Změněno/Opraveno)
- **Task update** — po dokončení tasku přepiš v `tasks/kos-XX.md` status na `Done (vX.Y, PR #N)`

### ❌ Nikdy
- Nespouštěj více vizuálních přepisů najednou (viz zahozenou v5 — poučení z praxe)
- Neměň audio engine a UI zároveň
- Nepřepisuj celé funkce pokud stačí opravit 2–3 řádky

---

## Struktura souboru `index.html`

```
<style>          ← veškerý CSS
<body>           ← HTML struktura syntetizátoru
<script>
  // WAVE SHAPE HELPERS (ikony waveform selectorů)
  // STATE (DEFS + objekt S)
  // ANALOG ENGINE — MS-20 CHARACTER
  //   waveshaper curves, buildDriftBuffer()
  //   initAudio(), buildIR()
  //   pulseWave() / setOscWave()  (PWM)
  //   buildVoice()
  //   noteOn() / noteOff() / allNotesOff()
  //   liveUpdate()
  // KNOBS (initKnobs)
  // ADSR FADERS (initFaders)
  // PATCH CABLES (initPatchbay / updatePatchRouting)
  // KEYBOARD (buildKeyboard, setupKey)
  // ARPEGGIATOR (initArp, arpStep, inputNoteOn/Off)
  // OCTAVE (changeOct)
  // WHEELS (createWheelCanvas, initWheels)
  // MIDI (initMIDI)
  // PRESETS (factory banka, applyState / captureState)
  // HELPERS + STATUS LOOP (toast, voice counter)
  // WOOD PANELS (drawWoodPanel / initWoodPanels)
  // BOOT (DOMContentLoaded)
```

---

## Klíčové funkce — kde co najít

| Funkce | Co dělá |
|--------|---------|
| `initAudio()` | Inicializace Web Audio contextu a efektů |
| `buildVoice(ctx, midi, vel, freq, now)` | Vytvoří 1 hlas (VCO→VCF→VCA) |
| `noteOn(midi, vel)` | Spustí hlas, voice stealing |
| `noteOff(midi, immediate)` | Zastaví hlas, release fáze |
| `inputNoteOn/Off(midi, vel)` | Vstupní vrstva (klávesy/MIDI) — routuje do arpu, nebo přímo na noteOn/Off |
| `liveUpdate(param, val)` | Real-time update parametru na hrajících hlasech |
| `initPatchbay()` | Patch kabely: verlet fyzika, drag, jacky; vystavuje `syncPatchCables()` a `isCableDrag()` |
| `updatePatchRouting()` | Zapne/vypne LFO→pitch/filter podle `S.patched` |
| `initArp()` / `arpStep()` | Arpeggiator UI + scheduler nad Web Audio clockem |
| `createWheelCanvas(housing, isPitch)` | Canvas renderer pro Pitch/Mod kolo |
| `drawWoodPanel(canvas, side)` | Canvas renderer pro dřevěné boky |
| `initKnobs()` / `initFaders()` | Drag handling pro rotační knoby a ADSR fadery |
| `buildKeyboard()` | Vykreslí klaviaturu od `S.octave` |
| `applyState(preset)` | Načte preset do UI + audio parametrů |
| `initMIDI()` | Web MIDI API, hot-plug, Note/Bend/CC handling |

---

## State objekt `S`

```javascript
S = {
  params: {...DEFS},  // viz níže; navíc arpRate (knob, log 1–20 Hz)
  octave: 3,          // aktuální oktáva
  vco1Wave, vco2Wave, lfoWave,   // waveformy (mimo params!)
  voices: new Map(),  // aktivní hlasy midiNote → voiceObj
  voiceList: [],      // FIFO pro voice stealing (maxVoices: 8)
  pitchBend: 0,       // ±1.0
  presets, activePreset,
  patched: { pitch, filter },    // patch kabely (KOS-17)
  arp: { on, mode, octaves, hold },  // arpeggiator (KOS-16)
  arpHeld: [], arpLatch: [],     // fyzicky držené / latchnuté noty
  // + audio nody (ctx, lfoNode, convolver, delayNode, masterGain, …)
}

DEFS = {
  // VCO
  vco1Freq, vco1Fine, vco1PW, vco1Level,
  vco2Freq, vco2Fine, vco2PW, vco2Level,
  // VCF
  hpfCutoff, lpfCutoff, resonance, filterEnvAmt,
  // EG1 (filtr) / EG2 (amplituda)
  eg1Attack, eg1Decay, eg1Sustain, eg1Release,
  eg2Attack, eg2Decay, eg2Sustain, eg2Release,
  // LFO (attenuatory kabelových cest)
  lfoRate, lfoPitch, lfoFilter,
  // Effects (delay time/feedback jsou fixní v initAudio)
  reverbMix, delayMix, chorusMix,
  // Master
  masterVol, glide,
}
```

---

## Otevřené tasky

Jediný zdroj pravdy je složka **`tasks/`** (`kos-{číslo}.md`, jeden soubor na task) — `Status: Todo` = otevřené, `Status: Done` = hotová historie. Tady v CLAUDE.md se tasky nevedou.

---

## Git workflow

```bash
# Před každým taskem
git checkout -b kos-XX-kratky-popis

# Po dokončení
git add index.html
git commit -m "KOS-XX: stručný popis co bylo změněno"
git push origin kos-XX-kratky-popis
# → otevřít Pull Request na GitHubu (gh pr create)
```

Branch naming: `kos-{číslo}-{slug}` (stejný formát jako Linear `gitBranchName`).

---

## Testování

Žádné automatické testy. Manuální checklist po každé změně:

- [ ] JS syntax check projde bez chyb
- [ ] Syntetizátor se načte v Chrome bez console errors
- [ ] MIDI klávesy fungují (Note On/Off, vizuální highlight)
- [ ] Presety se správně načítají (applyState)
- [ ] Změna oktávy překreslí klaviaturu
- [ ] Zvuk hraje bez artefaktů

---

## Komunikace

Projekt je vyvíjen česky. Commit messages jsou anglicky (konvence).
