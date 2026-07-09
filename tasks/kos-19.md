# KOS-19 — Fyzika patch kabelů: kabel je moc lehký, vznáší se

**Status:** Done (v5.7, PR #7)

## Popis

Patch kabely (KOS-17) se chovaly jako peříčko — padaly pomalu a plavaly ve vzduchu místo toho, aby se houpaly a usadily jako těžký gumový kabel. Navíc tažení kabelu přes klaviaturu spouštělo noty (mouseenter s drženým tlačítkem).

## Řešení

- Gravitace 1600 → 3200 px/s² — rychlý, těžký pád.
- Tlumení 0.955 → 0.98 na substep — kabel má setrvačnost, zhoupne se a rychle se usadí.
- Constraint solver 3 → 4 iterace, aby se lano při silnější gravitaci negumovalo.
- `window.isCableDrag()` z patchbaye + guard v `setupKey()` — během tažení propojky klávesy ignorují myš.
