# ------------------------------------------------------------------
# Triangle d'or de la flexisécurité danoise (chap3 §I.3, CM 9, CM 10).
# Chargé par :  source(here::here("R/fig_triangle_or.R"))
#
# fig_triangle_or(k, taille) :
#   k = 3 (défaut) : triangle complet, trois flèches doubles le long des
#                    côtés (renforcement mutuel), chacune légendée par le
#                    mécanisme qui relie les deux sommets.
#   k = 1, 2       : construction progressive pour les diapositives du CM 9
#                    (un sommet, puis deux sommets reliés par un pointillé).
#   taille         : taille du texte des sommets (3,5 chapitre, 3 diapos).
# Schéma conceptuel, sans données.
# ------------------------------------------------------------------
source(here::here("R/theme_macro.R"))
library(ggplot2)

fig_triangle_or <- function(k = 3, taille = 3.5) {

  h <- sqrt(3) / 2
  sommets <- data.frame(
    x = c(0, 1, 0.5),
    y = c(0, 0, h),
    # Étiquettes à l'extérieur : à gauche, à droite, au-dessus du sommet
    lx = c(-0.06, 1.06, 0.5),
    ly = c(0, 0, h + 0.08),
    hjust = c(1, 0, 0.5),
    vjust = c(0.5, 0.5, 0),
    label = c("Flexibilité\n(licenciements aisés,\nmobilité élevée)",
              "Indemnisation\ngénéreuse\n(niveau et durée)",
              "Activation\n(accompagnement,\ncontrôle, formation)")
  )

  # Côtés : 1 = Flexibilité-Indemnisation, 2 = Indemnisation-Activation,
  # 3 = Activation-Flexibilité. Flèches doubles parallèles au côté,
  # décalées vers l'intérieur et raccourcies pour ne pas toucher les sommets.
  centre <- c(0.5, h / 3)
  cotes <- data.frame(a = c(1, 2, 3), b = c(2, 3, 1))
  cotes$x1 <- sommets$x[cotes$a]; cotes$y1 <- sommets$y[cotes$a]
  cotes$x2 <- sommets$x[cotes$b]; cotes$y2 <- sommets$y[cotes$b]
  mx <- (cotes$x1 + cotes$x2) / 2; my <- (cotes$y1 + cotes$y2) / 2
  # vecteur unitaire du milieu du côté vers le centre
  nx <- centre[1] - mx; ny <- centre[2] - my
  nn <- sqrt(nx^2 + ny^2); nx <- nx / nn; ny <- ny / nn
  dec <- 0.06; rac <- 0.20
  fleches <- data.frame(
    x    = cotes$x1 + rac * (cotes$x2 - cotes$x1) + dec * nx,
    y    = cotes$y1 + rac * (cotes$y2 - cotes$y1) + dec * ny,
    xend = cotes$x2 - rac * (cotes$x2 - cotes$x1) + dec * nx,
    yend = cotes$y2 - rac * (cotes$y2 - cotes$y1) + dec * ny
  )
  # Mécanismes, écrits à l'extérieur de chaque côté
  mecanismes <- data.frame(
    x = mx - 0.07 * nx, y = my - 0.07 * ny,
    hjust = c(0.5, 0, 1), vjust = c(1, 0.5, 0.5),
    label = c("perte d'emploi indemnisée :\nla mobilité est mieux acceptée",
              "droits conditionnés\nà la recherche active",
              "formation et suivi :\nretour rapide à l'emploi")
  )

  p <- ggplot()

  if (k >= 3) {
    p <- p +
      geom_polygon(data = sommets, aes(x, y), fill = macro_pal["bleu2"], alpha = 0.10,
                   color = macro_pal["bleu"], linewidth = 0.9) +
      geom_segment(data = fleches, aes(x = x, y = y, xend = xend, yend = yend),
                   arrow = arrow(length = unit(0.22, "cm"), ends = "both", type = "closed"),
                   color = macro_pal["or"], linewidth = 0.8) +
      geom_text(data = mecanismes, aes(x, y, label = label, hjust = hjust, vjust = vjust),
                size = taille * 0.8, fontface = "italic", color = macro_pal["gris"],
                lineheight = 0.9)
  } else if (k == 2) {
    p <- p +
      annotate("segment", x = 0, y = 0, xend = 1, yend = 0, linetype = "dashed",
               color = macro_pal["gris"], linewidth = 0.5)
  }

  s <- sommets[seq_len(k), , drop = FALSE]
  p +
    geom_point(data = s, aes(x, y), size = 4, color = macro_pal["bleu"]) +
    geom_text(data = s, aes(lx, ly, label = label, hjust = hjust, vjust = vjust),
              size = taille, fontface = "bold", color = macro_pal["bleu"],
              lineheight = 0.9) +
    coord_fixed(clip = "off") +
    scale_x_continuous(limits = c(-0.62, 1.62)) +
    scale_y_continuous(limits = c(-0.22, h + 0.32)) +
    theme_void() +
    theme(plot.margin = margin(5, 5, 5, 5))
}
