# Macroéconomie 1 — Les Politiques Économiques (L2 AES)

Site de cours (résumés, slides, dossiers de TD) pour l'enseignement de **Macroéconomie 1 : Les Politiques Économiques**, L2 Administration Économique et Sociale (AES), Semestre 1.

**Enseignant :** Pierre Beaucoral (ATER, Université Clermont Auvergne).
D'après les cours de C. Mathonnat (2018-2019) et M. Ouedraogo (2025-2026).

## Contenu

- **3 résumés de cours** (`cours/`) : Chapitre I (introduction à la politique économique), Chapitre II (marché du travail), Chapitre III (politiques de l'emploi, cas français).
- **10 slides de CM** (`slides/`, RevealJS).
- **8 dossiers de TD** (`td/`), avec version PDF imprimable.
- Pages transverses : accueil, syllabus, ressources.

Les figures de données réelles sont générées en R (ggplot2) à partir de valeurs figées (INSEE, Eurostat, OCDE, Banque mondiale, WID), sans appel réseau au rendu.

## Construire le site

Prérequis : [Quarto](https://quarto.org), R (packages `ggplot2`, `here`, `sf`, `rnaturalearth`, `ggrepel`, …).

```bash
quarto render          # génère le site dans docs/
quarto preview         # prévisualisation locale
```

## Publication (GitHub Pages)

Le site est rendu dans `docs/`. Sur GitHub : *Settings → Pages → Source = Deploy from a branch → main / docs*.

## Note

Les corrigés de TD (`td/corrections/`) ne sont pas inclus dans ce dépôt (clés de réponses). Voir `.gitignore`.
