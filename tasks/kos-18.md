# KOS-18 — Factory presety předvádějící arp a patch kabely

**Status:** Done (v5.6, PR #6)

## Popis

Aktualizace factory presetů tak, aby funkce z v5.4/v5.5 byly slyšet hned po načtení. Bez změn enginu — jen data presetů.

- **FUGA 1497** — zvuk zachován (líbil se), přidán latched UP arp přes 2 oktávy (8.5 Hz) jako hypnotický bass groove; LFO dech přes FILTER kabel
- **EMINENT 310** — nahrazuje EQUINOXE (zněl nakřáple i po úpravě, zahozen); lush string machine **bez arpu**: dva sawy −6/+8 centů, chorus 0.85, smyčcová obálka, HPF 140
- **LASER HARP** — rychlý ping-pong arp (13 Hz, up-down) přes 3 oktávy s latch; čistý pluck, patchbay schválně prázdný
- **TOCCATA** — nahrazuje ZOOLOOK (nuda); barokní varhany: triangle + sinus +12, okamžitý attack / plný sustain, Leslie chorus + chrámový reverb, up-down arp figura (7 Hz, latch), vibrato přes PITCH kabel
- **OXYGENE IV** — kabelový showcase: wobble žije a umírá s FILTER kabelem, PITCH kabel nese jemné vibrato
- Všech 8 presetů má explicitní `arpRate` v params

## Poznámky z iterace

- Preset 5 prošel dvěma koly: EQUINOXE (arp showcase) → uhlazený EQUINOXE → zahozen úplně ve prospěch EMINENT 310 dle Oskara („nechme nějaký hezký zvuk bez arpu")
