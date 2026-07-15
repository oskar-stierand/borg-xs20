# CLAUDE.md — Instructions for Claude Code

This file describes how to work on the BORG XS-20 project. Always read it before making any code change.

---

## Project

**BORG XS-20** is a single-file web synthesizer in `index.html`. No build, no dependencies, no Node.js — everything lives in one file.

Tasks are tracked in the **`tasks/`** folder — one file per task, named `kos-{number}.md` (e.g. `tasks/kos-16.md`). Numbering is shared with the sister project BORG XR-09 (kos-20 through kos-28 belong to XR-09). We don't use Linear yet; the format is Linear-importable (H1 = title with ID, **Status:** Todo/In Progress/Done, Description section) and Oskar will bulk-upload the tasks later — do not change the structure.
Before starting any work, read the files with status `Todo` in `tasks/`.

---

## Working rules

### ✅ Always
- **Surgical changes** — only change what the task asks for. One task = one isolated change.
- **Syntax check** after every change: `node -e "new Function(js)"` on the JS block
- **Backup before changing** — copy the current `index.html` to `versions/index-vX.html`
- **Changelog** — before merging a PR, add a `## [X.Y] — YYYY-MM-DD` section to `CHANGELOG.md` (Added/Changed/Fixed subsections)
- **Task update** — after finishing a task, set the status in `tasks/kos-XX.md` to `Done (vX.Y, PR #N)`

### ❌ Never
- Don't run multiple visual rewrites at once (see the discarded v5 — a lesson learned in practice)
- Don't change the audio engine and the UI at the same time
- Don't rewrite whole functions when fixing 2–3 lines is enough

---

## Structure of `index.html`

```
<style>          ← all CSS
<body>           ← HTML structure of the synthesizer
<script>
  // WAVE SHAPE HELPERS (waveform selector icons)
  // STATE (DEFS + the S object)
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
  // PRESETS (factory bank, applyState / captureState)
  // HELPERS + STATUS LOOP (toast, voice counter)
  // WOOD PANELS (drawWoodPanel / initWoodPanels)
  // BOOT (DOMContentLoaded)
```

---

## Key functions — where to find what

| Function | What it does |
|----------|--------------|
| `initAudio()` | Web Audio context and effects initialization |
| `buildVoice(ctx, midi, vel, freq, now)` | Creates 1 voice (VCO→VCF→VCA) |
| `noteOn(midi, vel)` | Starts a voice, voice stealing |
| `noteOff(midi, immediate)` | Stops a voice, release phase |
| `inputNoteOn/Off(midi, vel)` | Input layer (keys/MIDI) — routes into the arp, or directly to noteOn/Off |
| `liveUpdate(param, val)` | Real-time parameter update on playing voices |
| `initPatchbay()` | Patch cables: verlet physics, dragging, jacks; exposes `syncPatchCables()` and `isCableDrag()` |
| `updatePatchRouting()` | Enables/disables LFO→pitch/filter based on `S.patched` |
| `initArp()` / `arpStep()` | Arpeggiator UI + scheduler on top of the Web Audio clock |
| `createWheelCanvas(housing, isPitch)` | Canvas renderer for the Pitch/Mod wheel |
| `drawWoodPanel(canvas, side)` | Canvas renderer for the wooden side panels |
| `initKnobs()` / `initFaders()` | Drag handling for rotary knobs and ADSR faders |
| `buildKeyboard()` | Renders the keyboard starting at `S.octave` |
| `applyState(preset)` | Loads a preset into the UI + audio parameters |
| `initMIDI()` | Web MIDI API, hot-plug, Note/Bend/CC handling |

---

## The `S` state object

```javascript
S = {
  params: {...DEFS},  // see below; plus arpRate (knob, log 1–20 Hz)
  octave: 3,          // current octave
  vco1Wave, vco2Wave, lfoWave,   // waveforms (outside params!)
  voices: new Map(),  // active voices midiNote → voiceObj
  voiceList: [],      // FIFO for voice stealing (maxVoices: 8)
  pitchBend: 0,       // ±1.0
  presets, activePreset,
  patched: { pitch, filter },    // patch cables (KOS-17)
  arp: { on, mode, octaves, hold },  // arpeggiator (KOS-16)
  arpHeld: [], arpLatch: [],     // physically held / latched notes
  // + audio nodes (ctx, lfoNode, convolver, delayNode, masterGain, …)
}

DEFS = {
  // VCO
  vco1Freq, vco1Fine, vco1PW, vco1Level,
  vco2Freq, vco2Fine, vco2PW, vco2Level,
  // VCF
  hpfCutoff, lpfCutoff, resonance, filterEnvAmt,
  // EG1 (filter) / EG2 (amplitude)
  eg1Attack, eg1Decay, eg1Sustain, eg1Release,
  eg2Attack, eg2Decay, eg2Sustain, eg2Release,
  // LFO (attenuators of the cable paths)
  lfoRate, lfoPitch, lfoFilter,
  // Effects (delay time/feedback are fixed in initAudio)
  reverbMix, delayMix, chorusMix,
  // Master
  masterVol, glide,
}
```

---

## Open tasks

The single source of truth is the **`tasks/`** folder (`kos-{number}.md`, one file per task) — `Status: Todo` = open, `Status: Done` = finished history. Tasks are not tracked here in CLAUDE.md.

---

## Git workflow

```bash
# Before each task
git checkout -b kos-XX-short-slug

# After finishing
git add index.html
git commit -m "KOS-XX: brief description of what changed"
git push origin kos-XX-short-slug
# → open a Pull Request on GitHub (gh pr create)
```

Branch naming: `kos-{number}-{slug}` (same format as Linear `gitBranchName`).

---

## Testing

No automated tests. Manual checklist after every change:

- [ ] JS syntax check passes without errors
- [ ] The synthesizer loads in Chrome without console errors
- [ ] MIDI keys work (Note On/Off, visual highlight)
- [ ] Presets load correctly (applyState)
- [ ] Changing the octave redraws the keyboard
- [ ] Sound plays without artifacts

---

## Language policy

Development communication with Oskar is in **Czech**. Everything in the public repo is in **English**: README, CHANGELOG, CLAUDE.md, task files in `tasks/`, code comments, and commit messages.
