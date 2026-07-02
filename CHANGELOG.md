# Changelog — BORG XS-20

Všechny změny jsou řazeny od nejnovějších. Formát vychází z [Keep a Changelog](https://keepachangelog.com/).

---

## [5.4] — 2026-07-02

### Přidáno
- **Patch kabely (KOS-17)** — první semi-modulární propojky: jacky LFO OUT, PITCH 1+2 (moduluje oba VCO) a FILTER IN; verlet fyzika kabelů (gravitace, průvěs, houpání, dokmitávání), tažení z libovolného konce (OUT→IN i IN→OUT), magnetický přítah + zvýraznění cílového jacku, upuštěný kabel spadne a rozplyne se
- **Normalling** — modulační cesty LFO→pitch/filter hrají jen se zapojeným kabelem; knoby →PITCH/→FILTER fungují jako attenuatory; boot má oba kabely zapojené (zachování dosavadního chování); stav kabelů se ukládá do presetů
- **Auto-slyšitelnost** — zapojení kabelu s attenuatorem na nule ho zvedne na slyšitelnou hodnotu (→FILTER 0.35, →PITCH 0.15) včetně vizuálu knobu

---

## [5.3] — 2026-07-02

### Změněno
- **ADSR: vertikální fadery místo knobů (KOS-15)** — 8 obálkových parametrů (EG1 FILTER + EG2 AMP, A/D/S/R) je nyní ovládáno fadery: zapuštěný slot s bočními dílky, ivory cap ladící s klaviaturou, barevná výplň hodnoty (EG1 oranžová, EG2 jantarová); drag nahoru = zvýšit, dblclick = reset na default; capy vedle sebe vizuálně kreslí tvar obálky
- Ostatní knoby (VCO, VCF, LFO, FX, MASTER, GLIDE) zůstávají rotační
- Log škála časových parametrů (A/D/R) i kompatibilita presetů zachována (`applyState` nastavuje pozice faderů)

---

## [5.2] — 2026-07-02

### Změněno
- **Dřevěné boky: bahenní dub (KOS-14)** — tmavá, odsaturovaná šedohnědá paleta místo medovo-oranžového dubu; per-pixel letokruhy (value noise / fBm) s virtuální dření mimo panel → katedrální oblouky podél desky; medullary ray flecks (stříbřité čočky napříč letokruhy); chladnější varniš i hranové odlesky

### Opraveno
- **DPR bug v `drawWoodPanel()`** — funkce četla rozměry v device pixelech, ale kontext už byl škálovaný přes `devicePixelRatio` → textura se kreslila 2× větší a ořezávala se; nyní se kreslí v CSS pixelech

---

## [5.1] — 2026-07-02

### Změněno
- **Pitch/Mod kola: realistická projekce (KOS-13)** — žebra běží rovnoběžně s osou otáčení, takže se promítají jako rovné pruhy v plné šířce ráfku (dřívější sférická projekce dělala z kol „soudek"); barevný marker jede s povrchem gumy místo fixní pozice na rovníku; povrch nyní sleduje směr tahu prstem
- **Guma kol** — statická mikro-zrno textura (overlay composite), spekulární highlight na horní hraně každého žebra (světlo shora), silnější středový odlesk

---

## [5.0] — 2026-07-02

### Opraveno
- **FX routing** — reverb, delay a chorus byly úplně odpojené (série connect/disconnect v `initAudio()` odpojila jejich vstupy); nový čistý řetězec: voices → voiceBus → dry + FX sends → master → limiter
- **Presety: překreslení klaviatury** — `applyState()` nyní při změně oktávy volá `buildKeyboard()`
- **Presety: LFO waveform** — `applyState()` nyní propisuje `lfoWave` i do audio node
- **Knoby mazaly stisknuté klávesy** — odstraněno bludné čištění highlightů v `liveUpdate()`
- **MIDI pitch bend** — nyní se aplikuje na hrající hlasy (sdílený `applyPitchBend()` s kolečkem)
- **Únik paměti LFO** — globální LFO tapy se po dohrání hlasu odpojují (`onended` cleanup)

### Přidáno
- **Skutečná pulzní šířka (PWM)** — P.WIDTH knoby generují Fourier PeriodicWave (cache per duty); funguje live i z presetů
- **Stereo šířka hlasů** — subtle per-voice random pan ±0.12 (analog voice-card spread)
- **Tmavší reverb** — one-pole lowpass přes IR s klesajícím cutoffem podél tailu

### Změněno
- **Klávesy** — realistická slonovina (vícestupňový gradient, boční bevely, přední hrana), černé klávesy s lakovaným leskem a šikmým čelem
- **Knoby** — vroubkovaný úchop (knurl ticks), spekulární odlesk, hlubší kovové gradienty
- **Pitch/Mod kolečka** — Retina 2× rendering

---

## [4.1-bugfix] — 2026-03-04

### Opraveno
- **MIDI vizuální zpětná vazba** — MIDI Note On/Off nyní spouští vizuální efekt zmáčknutí klávesy (`highlight()`) stejně jako computer keyboard a klik myší
- **Oktáva klaviatury** — `buildKeyboard()` nyní používá `S.octave` jako základ místo hardcoded C3; klávesnice se korektně překreslí při změně oktávy
- `allNotesOff()` nyní také čistí vizuální highlighty kláves

---

## [4.0] — 2026-02-26

### Přidáno
- **Steiner-Parker filtr** — 2× kaskádní biquad LPF s asymetrickým rozladěním, saturace mezi póly
- **3-stupňová saturace** — pre-filter (asymetrický tanh), resonance (soft limiter), post-filter (Chebyshev VCA)
- **Termální VCO drift** — 8s pink noise buffer (1/f), ±6 centů, nezávislý per-oscilátor a per-hlas
- **Sub-audio breath noise** — loopovaný šum −38 dB pro živost signálu
- **Exponenciální ADSR** — `setTargetAtTime(τ = time/3)` místo lineárních ramp
- **8-hlasá polyfonie** se stealingem (FIFO), portamento zachováno

### Odstraněno
- Poly mode toggle — nahrazen statickým `8× ANALOG` badge (polyfonie je vždy aktivní)

### Změněno
- Všechny factory presety aktualizovány (odstraněno `polyMode` pole)

---

## [3.0] — 2026-02-26

### Přidáno
- **Dřevěné boky** — canvas procedurální rendering (letokruhy, zrno, lak, stíny)
- Diagnóza audio enginu — identifikováno 6 klíčových DSP problémů oproti analogovému MS-20

---

## [2.0] — 2026-02-26

### Přidáno
- **Pitch/Mod kola** — canvas cylinder renderer s perspektivním zkosením a světelnými efekty
- **8 factory presetů** — CHILDREN, FUGA 1497, DREAMLAND, OXYGENE, EQUINOXE, HYPNOTIQUE, ACID SEQUENCE, PAD ATMOSPHERIQUE
- Přejmenování projektu na **BORG XS-20**

### Opraveno
- Zarovnání černých kláves na klaviatuře

---

## [1.0] — 2026-02-26

### Přidáno
- Základní Web Audio API engine — 2× VCO, VCF (HPF + LPF), VCA
- ADSR obálky EG1 (filtr) a EG2 (amplituda)
- LFO s modulací pitch a filtru
- Efekty: reverb (IR convolution), tape delay, bucket-brigade chorus
- Piano klaviatura (3 oktávy, 37 kláves)
- **MIDI podpora** — Note On/Off s velocity, Pitch Bend (±2 půltóny), CC1 Mod Wheel, CC7 Volume, hot-plug, LED indikátor
- Computer keyboard podpora (A–K, W/E/T/Y/U, Z/X oktávy)
- Rotační knoby s SVG renderingem
- UI inspirované vintage MS-20 hardware
