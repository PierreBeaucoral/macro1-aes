# ------------------------------------------------------------------
# Courbe de Beveridge (CM 8 et chap2, §2.4).
# Chargé par :  source(here::here("R/fig_beveridge.R"))
#
# 1. fig_beveridge_france() : données françaises 2013-2025.
#    Chômage : série canonique du cours, WDI SL.UEM.TOTL.NE.ZS (Banque
#    mondiale, chômage national BIT). Emplois vacants : Eurostat
#    jvs_q_nace2, indicateur JVR, secteurs B-S, toutes tailles, données
#    brutes, moyenne des trimestres (2020 : T2-T4, T1 non publié).
#    Valeurs extraites des API Banque mondiale et Eurostat le 2026-10-19.
# 2. fig_beveridge_theta() : bouclage du modèle DMP, la tension
#    d'équilibre theta* fixe le rayon v = theta* u, dont l'intersection
#    avec la courbe de Beveridge donne u*. Valeurs illustratives.
# ------------------------------------------------------------------
source(here::here("R/theme_macro.R"))
library(ggplot2)
library(ggrepel)

bev_fr <- data.frame(
  annee   = 2013:2025,
  chomage = c(9.91, 10.27, 10.35, 10.06, 9.41, 9.02, 8.42,
              8.01, 7.87, 7.30, 7.34, 7.44, 7.70),
  vacance = c(0.95, 1.00, 1.08, 1.38, 1.78, 1.88, 2.15,
              2.03, 2.68, 3.35, 3.10, 2.63, 2.40),
  periode = factor(rep(c("2013-2019", "2020-2023", "2024-2025"), c(7, 4, 2)),
                   levels = c("2013-2019", "2020-2023", "2024-2025"))
)

fig_beveridge_france <- function() {
  # Courbe d'avant-crise : droite ajustée sur 2013-2019, prolongée en
  # pointillés pour situer les années suivantes au-dessus ou en dessous.
  avant <- coef(lm(vacance ~ chomage, data = subset(bev_fr, annee <= 2019)))
  cols  <- c("2013-2019" = macro_pal[["bleu"]], "2020-2023" = macro_pal[["rouge"]],
             "2024-2025" = macro_pal[["or"]])

  ggplot(bev_fr, aes(x = chomage, y = vacance)) +
    geom_abline(intercept = avant[1], slope = avant[2], linetype = "dashed",
                colour = macro_pal[["bleu"]], alpha = 0.5, linewidth = 0.6) +
    annotate("text", x = 9.25, y = 1.35, label = "tendance 2013-2019 prolongée",
             hjust = 1, size = 2.8,
             colour = macro_pal[["bleu"]]) +
    geom_path(colour = "grey60", linewidth = 0.5) +
    geom_point(aes(colour = periode), size = 3) +
    geom_text_repel(aes(label = annee), size = 2.7, fontface = "bold",
                    colour = "#333333", point.padding = 0.3, min.segment.length = 1,
                    seed = 1) +
    # Groupes nommés directement plutôt que par une légende.
    annotate("text", x = 9.6, y = 0.7, label = "2013-2019", hjust = 0, size = 3,
             fontface = "bold", colour = cols[["2013-2019"]]) +
    annotate("text", x = 7.45, y = 3.45, label = "2020-2023", hjust = 0, size = 3,
             fontface = "bold", colour = cols[["2020-2023"]]) +
    annotate("text", x = 6.95, y = 2.15, label = "2024-2025", hjust = 0, size = 3,
             fontface = "bold", colour = cols[["2024-2025"]]) +
    scale_colour_manual(values = cols, name = NULL) +
    coord_cartesian(xlim = c(6.5, 11), ylim = c(0.5, 3.6), expand = FALSE) +
    labs(x = "Taux de chômage (BIT, %)", y = "Taux d'emplois vacants (%)") +
    theme_macro() +
    theme(legend.position = "none")
}

fig_beveridge_theta <- function() {
  # Courbe de Beveridge v = 8 / u ; rayons v = theta u. Intersection :
  # u = sqrt(8 / theta), v = sqrt(8 theta).
  # Rayons tracés jusqu'à v = 6 : theta* = 1,5 (u = 4), theta*' = 0,8 (u = 7,5).
  u  <- seq(1, 8, length.out = 200)
  th <- c(1.5, 0.8)
  eq <- data.frame(u = sqrt(8 / th), v = sqrt(8 * th), lab = c("E", "E'"))

  ggplot() +
    geom_line(aes(x = u, y = 8 / u), colour = macro_pal[["bleu"]], linewidth = 1.1) +
    annotate("text", x = 7.2, y = 8 / 7.2 + 0.35, label = "Beveridge", size = 3.2,
             fontface = "bold", colour = macro_pal[["bleu"]]) +
    annotate("segment", x = 0, y = 0, xend = 4, yend = 6, colour = macro_pal[["or"]],
             linewidth = 0.9) +
    annotate("text", x = 4.1, y = 6, label = "v = θ* u", hjust = 0, size = 3.2,
             fontface = "bold", colour = macro_pal[["or"]]) +
    annotate("segment", x = 0, y = 0, xend = 7.5, yend = 6, colour = macro_pal[["or"]],
             linewidth = 0.9, linetype = "dashed") +
    annotate("text", x = 7.6, y = 6, label = "v = θ*' u\n(θ*' < θ*)", hjust = 0,
             size = 3.2, fontface = "bold", colour = macro_pal[["or"]]) +
    geom_segment(data = eq, aes(x = u, xend = u, y = 0, yend = v), linetype = "dashed",
                 colour = "grey50", linewidth = 0.4) +
    geom_point(data = eq, aes(x = u, y = v), colour = macro_pal[["rouge"]], size = 2.6) +
    geom_text(data = eq, aes(x = u + 0.25, y = v + 0.3, label = lab), fontface = "bold",
              colour = macro_pal[["rouge"]]) +
    scale_x_continuous(breaks = eq$u, labels = c("u*", "u*'")) +
    scale_y_continuous(breaks = NULL) +
    coord_cartesian(xlim = c(0, 9.5), ylim = c(0, 7), expand = FALSE) +
    labs(x = "Taux de chômage (u)", y = "Taux d'emplois vacants (v)") +
    theme_macro() +
    theme(panel.grid = element_blank())
}
