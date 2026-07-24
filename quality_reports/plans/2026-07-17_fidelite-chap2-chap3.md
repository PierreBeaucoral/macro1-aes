# Plan d'ajustement — Mise à parité des résumés chap2 & chap3 avec leurs slides

Statut : APPROUVÉ POUR EXÉCUTION · Date : 2026-07-17
Fondé sur deux audits Opus (chap2 vs cm03-08 ; chap3 vs cm09-10), avec `cours/chap1.qmd` comme référence de fidélité.
Scores de fidélité de départ : **chap2 = 62/100**, **chap3 = 72/100**.

## Principe directeur (repris de chap1)
Le résumé doit refléter ses slides sur quatre plans : **données** (mêmes valeurs/périodes/sources), **concepts**, **notation/message**, **visualisations**. Les figures des slides sont mirrorées dans le résumé en **version STATIQUE** :
- Copier le bloc de données inline + le `ggplot` depuis le deck source (les données des slides chap II/III sont **figées en dur inline**, pas de CSV).
- Retirer toute animation RevealJS (`::: {.r-stack}` / `::: {.fragment}` / appels `plot_x(k)`) : ne garder que l'**état final** (ex. appeler la fonction avec l'argument complet).
- Renommer les `#| label:` pour éviter les collisions (suffixe `-resume` si besoin) ; conserver les `#| fig-cap:` (sources déjà rédigées).
- Contraintes : AUCUN em-dash « — » ; aucune fonction réseau (données figées) ; pas de titre dans le ggplot (titre en fig-cap) ; `source(here::here("R/theme_macro.R"))`, `theme_macro()`, `macro_pal`. Valider chaque chunk via `Rscript` (hors-ligne). NE PAS lancer `quarto render` (le rendu se fait en fin de passe).

## Modèle d'exécution
**2 agents Sonnet en parallèle** (fichiers disjoints : `cours/chap2.qmd` vs `cours/chap3.qmd`, pas de conflit). Chaque agent lit ses decks sources et applique la liste ci-dessous. Après les deux agents : rendu complet + re-vérification Opus des deux résumés.

---

## AGENT 1 — `cours/chap2.qmd` (lit cm03, cm04, cm05, cm06, cm07, cm08)

### A. Corrections de données (priorité 1)
- **A1.** Remplacer le tableau `tbl-norvege-espagne` (§1.3, valeurs FABRIQUÉES : Norvège/Espagne, chômage 6 % fictif) par la figure réelle **Suède vs Italie 2023** (`fig-suede-italie` de cm03, données Eurostat : même chômage 7,7 %, emploi 80,7 % vs 61,5 %, activité 87,4 % vs 66,6 %). Version statique (3 barres, état final).
- **A2.** Aligner l'entité comparée de `fig-hysteresis-us-europe` : passer de « Europe continentale » à **France** en reprenant les données de `fig-hysteresis-us-fr` de cm04 (BLS + INSEE/OCDE), pour coïncider avec les slides. (Le message reste identique ; on nomme la France comme dans le deck.)

### B. Viz de données réelles à mirrorer (priorité 2) — recopier depuis le deck, statique
| Figure (deck source) | Montre | Section cible du résumé |
|---|---|---|
| `fig-chomage-international` (cm03) | Chômage harmonisé 2023, 11 pays, France mise en avant | §1.2 (modèles nationaux) |
| `fig-carte-chomage-ue` (cm03) ou `fig-carte-chomage-europe` (cm04/cm08) | Carte choroplèthe chômage UE, clivage Nord/Sud | §1.2 |
| `fig-bit-vs-france-travail` (cm03) | **INSEE (BIT) vs France Travail (cat. A, A+B+C)** en série 2010-2024 | §1.3 (mesures) |
| `fig-ltu-us-fr` (cm04) | Part chômeurs longue durée US vs France 2000-2019 | §1.5 |
| `fig-divergence-europe` (cm04) | Chômage 5 pays 1994-2015 (divergence européenne) | §1.5 |
| `fig-heures-longterme` (cm05) | Heures travaillées France 1950-2019 + repères | §2.1 |
| `fig-coin-fiscal-ocde` (cm05) | Coin fiscal OCDE 2023, France 47 % vs moyenne 35 % | §2.1 |
| `fig-kaitz-ocde` (cm05) | Indice de Kaitz (SMIC/médian), France 0,61 | §2.1 |
| `fig-okun-nuage` (cm06) | **Nuage d'Okun réel** France/US 1991-2023 | §2.2 |
| `fig-phillips-reel` (cm07) | **Phillips réelle** US 1960-69 (tient) vs 1970-84 (rompt) | §2.2 (Phillips) |
| `fig-stagflation-cm07` (cm07) | Chômage + inflation US 1968-1985, chocs 1973/1979 | §2.2 |
| `fig-beveridge-france` (cm08) | **Courbe de Beveridge France réelle** 2013-2024 | §2.4 |

Facultatif si le temps le permet (données réelles secondaires) : `fig-cycle-chomage-cm06`, `fig-divergence-cm07`, seconde carte 2005 vs 2023.

### C. Concepts à ajouter / renforcer (priorité 3)
- **C1.** Définir explicitement l'**indice de Kaitz** (§2.1, avec `fig-kaitz-ocde`).
- **C2.** Définir explicitement le **coin fiscal** (tax wedge) et son mécanisme (déplace L^d vers la gauche) (§2.1, avec `fig-coin-fiscal-ocde`).
- **C3.** Chiffrer le **NAIRU** (~6 % US, ~9-10 % Europe) là où il est défini (§2.2).
- **C4.** Ajouter la **nuance heures travaillées / effet revenu de long terme** (durée du travail ÷2 quand salaire réel ×10) qui nuance l'hypothèse « effet substitution domine » (§2.1, avec `fig-heures-longterme`).
- **C5.** Lister nommément les **cinq catégories A-E** de France Travail (§1.3).

### D. Optionnel (priorité 4) — diagrammes Mermaid
Cercle de l'hystérèse (cm04), spirale déflationniste (cm06), trois flux emploi/chômage/inactivité (cm08). Non bloquant.

---

## AGENT 2 — `cours/chap3.qmd` (lit cm09, cm10)

### A. Correction de données (priorité HAUTE, cohérence transversale)
- **A1.** Réaligner `fig-chomage-fr` : chap3 utilise actuellement la série **INSEE idbank 001688527** (pic milieu 90s ≈ 10,6 %), alors que `fig-chomage-fr-cm10` ET la référence `fig-france-croissance-chomage` de chap1 utilisent la série **Banque mondiale SL.UEM.TOTL.NE.ZS** (pic ≈ 12,6 %). chap3 est le seul écart du cours (violation INV-11 transversale : deux histoires du chômage français). → **Recopier le vecteur de valeurs de cm10** (série WDI) pour uniformiser.
  - **Décision à confirmer par Pierre** : uniformiser sur WDI (défaut, minimise les changements, aligne sur chap1/cm10) OU, s'il préfère la série officielle INSEE métropolitaine, il faudrait alors modifier AUSSI chap1 et cm10. Défaut d'exécution : **WDI**.

### B. Viz de données réelles à mirrorer (priorité HAUTE) — depuis cm10, statique
| Figure (cm10) | Montre | Section cible |
|---|---|---|
| `fig-emploi-seniors-cm10` | Taux d'emploi des 55-64 ans, FR/DE/SE/UE27, 2000-2023 (France 15-20 pts sous) — Eurostat `lfsa_ergan` | Section II, Axe 3, près du callout « réforme des retraites 2023 » (la claim « taux d'emploi des seniors bas » est actuellement orpheline) |
| `fig-cdd-stock-flux-cm10` | Contrats courts 1982-2023 : stock (~11-13 %) vs flux (~90 % des embauches) — Insee enquêtes Emploi + DARES DMMO-EMMO | Section II.2 « Synthèse et résultats » (illustre « flexibilisation = contrats courts sans baisse du chômage structurel ») |

### C. Viz stylisée à mirrorer (priorité MOYENNE, forte valeur pédagogique)
- **C1.** `fig-trappe-cm10` (profil revenu disponible vs revenu d'activité : RMI pente ~0 / RSA pente 0,62 / prime d'activité) — matérialise « pente » et « taux marginal implicite ». Version statique (état final = `plot_trappe(3)`). Insérer Section II, Axe 3, après la définition de la trappe / le mermaid `fig-sequence-rsa`. Source : DARES 2016 (pente RSA 0,62).

### D. Concept à renforcer (priorité MOYENNE)
- **D1.** Expliciter la **correspondance axe de réforme → diagnostic théorique du chapitre II** (Axe 1 → néoclassique/coût du travail ; Axe 2 → WS-PS/appariement ; Axe 3 → trappe/appariement), sous forme de court tableau ou paragraphe, en tête de Section II (repris de cm10).

### E. Optionnel (priorité BASSE)
Upgrade du mermaid `fig-frise-reformes` vers une frise plottée type `fig-chronologie-cm10` ; diagrammes « découplage protection emploi/travailleurs » (cm09) et « deux typologies flexibilité/sécurité » (cm09).

---

## Vérification (après exécution des 2 agents)
1. `quarto render cours/chap2.qmd` et `cours/chap3.qmd` (séparément) → exit 0.
2. `grep -c '—'` = 0 dans les deux fichiers.
3. Aucun appel réseau vivant ; aucun label de figure dupliqué.
4. Re-lancer une **critique Opus de fidélité** sur chap2 et chap3 → viser ≥ 90/100.
5. Rendu complet du site + ouverture visuelle.
