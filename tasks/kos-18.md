# KOS-18 — Factory presets showcasing the arp and patch cables

**Status:** Done (v5.6, PR #6)

## Description

Update the factory presets so the v5.4/v5.5 features are audible right after loading. No engine changes — preset data only.

- **FUGA 1497** — sound preserved (it was liked), added a latched UP arp across 2 octaves (8.5 Hz) as a hypnotic bass groove; LFO breathing via the FILTER cable
- **EMINENT 310** — replaces EQUINOXE (sounded raspy even after tweaking, dropped); lush string machine **without arp**: two saws −6/+8 cents, chorus 0.85, string envelope, HPF 140
- **LASER HARP** — fast ping-pong arp (13 Hz, up-down) across 3 octaves with latch; clean pluck, patchbay intentionally empty
- **TOCCATA** — replaces ZOOLOOK (boring); baroque organ: triangle + sine +12, instant attack / full sustain, Leslie chorus + church reverb, up-down arp figure (7 Hz, latch), vibrato via the PITCH cable
- **OXYGENE IV** — cable showcase: the wobble lives and dies with the FILTER cable, the PITCH cable carries subtle vibrato
- All 8 presets have an explicit `arpRate` in params

## Iteration notes

- Preset 5 went through two rounds: EQUINOXE (arp showcase) → smoothed EQUINOXE → dropped entirely in favor of EMINENT 310 per Oskar ("let's keep one nice sound without the arp")
