# Audit pré-publication — Site Macroéconomie 1 (L2 AES)

Date : 2026-07-22 · Statut : **PRÊT À PUBLIER**

## Méthode
1. Passe mécanique déterministe (Bash) sur tous les `.qmd`/configs.
2. Audit de contenu : 15 agents Opus (résumés, slides, TD, transverse, cohérence), contre la checklist des remarques de l'enseignant.
3. Remédiation : 3 corrections globales + 10 agents (majeurs) + 15 agents (mineurs) + 2 résidus.
4. Re-vérification finale : 2 agents Opus (cohérence des séries France ; débordements/exactitude).

## Résultat de l'audit
- Passe mécanique : **propre** (0 em-dash ; 0 appel réseau ; 0 donnée fabriquée présentée comme réelle ; rendu exit 0 ; 8 PDF TD ; citations et renvois croisés tous résolus).
- Audit contenu : **0 bloquant**, 17 majeurs, 40 mineurs.

## Corrections appliquées (majeurs + mineurs à valeur)
- **Cohérence des données France** : série de croissance du PIB réel et de chômage alignées sur un millésime WDI unique dans TOUTES les figures (croissance 2009=-2,9 ; 2019=1,8 ; 2020=-7,5 ; 2021=6,9 ; chômage pic 12,6 % 1994/1997, 2008=7,4, 2015=10,4, 2024=7,4) ; code indicateur SL.UEM.TOTL.NE.ZS partout ; coin d'inflation recalculé cohérent.
- **Débordements de diapos** corrigés (cm01, cm03, cm04, cm08, cm10) : fig-height réduits, callouts déplacés, sources repliées dans les fig-cap.
- **Ordre pédagogique** : courbe de Phillips modélisée AVANT le nuage réel (cm07, comme le résumé).
- **Exactitude économique** : critères BIT (semaine de référence vs 4 semaines de recherche) ; barème prud'homal = ordonnances Macron 2017 ; heures/salaire réel ×5 (et non ×10) ; citation d'Okun non anachronique ; chômage « autour de 3 % » ; réponse keynésienne salaires nominaux nuancée.
- **TD** : td5 énoncé non résolu (solution dans le corrigé seul) ; CC1/CC2 = sujets d'entraînement originaux avec réponses exemples ; nom/affiliation (Pierre Beaucoral, ATER, UCA) sur les TD + PDF imprimables ; liens de corrigés retirés (plus de fuite de source dans docs/).
- **Éditorial** : auteur normalisé (M. Ouedraogo 2025-2026, C. Mathonnat 2018-2019 ; suppression d'un auteur fantôme) ; syllabus nomme l'enseignant et la permanence.

## Vérification finale (Opus)
- Chômage français : **cohérent partout**. Croissance : **cohérente** après correction des nuages d'Okun. Code indicateur : conforme.
- Débordements, ordre Phillips, critères BIT, figure td5, exactitude des points corrigés : **tous OK**. Verdict agent : « prêt à publier : OUI ».

## Réserves mineures non bloquantes (cosmétiques, laissées)
- Diapo cm04 `fig-ltu-us-fr` la plus tendue verticalement (~555px/660) : passe, à surveiller au rendu réel.
- Quelques titres de diapo encore descriptifs plutôt qu'affirmatifs (cm01, cm09).
- Diagrammes Mermaid conceptuels au thème par défaut (lisibles ; la frise problématique a été convertie en ggplot).
- Chômage pré-1980 (hors WDI) : arrondis 4,0 vs 4,1 selon la figure.

## Sortie
25 pages HTML · 8 PDF de TD · 144 figures · `output-dir: docs/` prêt pour GitHub Pages.
