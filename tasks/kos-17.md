# KOS-17 — Patch kabely MVP: MG→FILTER / MG→PITCH s Reason-style fyzikou

**Status:** Done (v5.4, PR #4)

## Popis

První kabelové propojky à la MS-20 patchbay. MVP záměrně bez robustního systému — 3 jacky, 2 možné kabely, nula nového DSP (obě modulační cesty v enginu už existují: `lfoGain`, `lfoFiltGain`).

### Jacky
- **MG OUT** — v sekci MG · LFO & FX (zdroj, pojme až 2 kabely)
- **FILTER IN** — v sekci VCF (cíl, 1 kabel)
- **PITCH IN** — v sekci VCO·1 (cíl, 1 kabel)

### Normalling (semi-modulární logika MS-20)
- Zapojený kabel = modulační cesta aktivní; knoby →FILTER / →PITCH fungují jako attenuatory
- Vytažený kabel = cesta mrtvá (knob nehraje), vč. mod wheelu u pitch cesty
- **Boot: oba kabely zapojené** — zachová dosavadní chování i presety
- Stav kabelů se ukládá do presetů (`captureState`/`applyState`; staré presety bez pole = zapojeno)

### Kabelová fyzika a vzhled (Reason laťka)
- **Verlet simulace** — řetízek ~14 bodů, gravitace, tlumení, konce přišpendlené k jackům; kabel se prohýbá vlastní vahou, po pohybu se zhoupne a dokmitá
- **Tažení s vláčením** — volný konec se za kurzorem vleče a vlní; blízko kompatibilního jacku magnetický přítah + zvýraznění; puštění mimo = kabel spadne a zmizí
- **Rendering** — canvas overlay přes celé okno: 3 tahy (stín pod kabelem, barevné tělo, světlá linka lesku), kovové jack plugy s barevnou bužírkou
- Barvy kabelů z palety (červená/žlutá/modrá)
- Jack: kovový kroužek s tmavou dírou (vnitřní stín), mini popisek

### Vědomá omezení
- PWM přes kabel ne — pulse width není AudioParam (PeriodicWave přepočet)
- Zpětnovazební smyčky nevznikají (pevné směry OUT→IN)

### Doplněno během implementace (feedback Oskara)
- Tažení kabelu z libovolného konce — i z prázdného IN jacku směrem ke zdroji
- Jacky přejmenovány: LFO OUT (místo MG OUT), PITCH 1+2 (moduluje oba VCO)
- Auto-slyšitelnost: zapojení kabelu s attenuatorem na nule zvedne knob na slyšitelnou hodnotu (→FILTER 0.35, →PITCH 0.15)
