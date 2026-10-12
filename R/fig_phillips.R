# ------------------------------------------------------------------
# Schémas des mécanismes de la courbe de Phillips (CM 7 et chap2, §2.2).
# Valeurs illustratives. Chargé par :  source(here::here("R/fig_phillips.R"))
#
# Courbe de Phillips augmentée : pi = pi_a - a (u - u_n), avec a = 1 et
# u_n = 7 % pour des pas ronds (chaque point de chômage sous u_n coûte
# 1 point d'inflation au-dessus de l'inflation anticipée).
# ------------------------------------------------------------------
source(here::here("R/theme_macro.R"))

phil_un <- 7
phil_ct <- function(u, pi_a) pi_a - (u - phil_un)

fleche <- function(x, y, xend, yend, col, lty = "solid") {
  annotate("segment", x = x, y = y, xend = xend, yend = yend, colour = col,
           linewidth = 0.9, linetype = lty,
           arrow = arrow(length = unit(0.22, "cm"), type = "closed"))
}

point_lab <- function(x, y, lab, col = "black", hjust = -0.5, vjust = 0.5) {
  list(annotate("point", x = x, y = y, size = 3, colour = col),
       annotate("text", x = x, y = y, label = lab, hjust = hjust, vjust = vjust,
                fontface = "bold", size = 4, colour = col))
}

axes_phillips <- function(xlim, ylim) {
  list(coord_cartesian(xlim = xlim, ylim = ylim, expand = FALSE),
       scale_x_continuous(breaks = seq(2, 10, 1)),
       scale_y_continuous(breaks = seq(-2, 8, 2)),
       labs(x = "Taux de chômage (%)", y = "Taux d'inflation (%)"),
       theme_macro(),
       theme(legend.position = "none"))
}

# 1. Lecture keynésienne : une courbe stable, la relance déplace l'économie
#    le long de la courbe (A -> B), la rigueur en sens inverse.
fig_phillips_arbitrage <- function() {
  courbe <- data.frame(u = seq(3, 10, length.out = 200))
  courbe$pi <- -2 + 24 / courbe$u
  arc <- subset(courbe, u >= 4.15 & u <= 5.85)

  ggplot(courbe, aes(u, pi)) +
    geom_line(linewidth = 1.1, colour = macro_pal[["bleu"]]) +
    geom_path(data = arc[order(-arc$u), ], aes(u, pi + 0.45), colour = macro_pal[["rouge"]],
              linewidth = 0.9, arrow = arrow(length = unit(0.22, "cm"), type = "closed")) +
    annotate("segment", x = c(6, 4), xend = c(6, 4), y = -1, yend = c(2, 4),
             linetype = "dotted", colour = macro_pal[["gris"]]) +
    annotate("segment", x = 3, xend = c(6, 4), y = c(2, 4), yend = c(2, 4),
             linetype = "dotted", colour = macro_pal[["gris"]]) +
    point_lab(6, 2, "A", hjust = -0.6, vjust = 1.2) +
    point_lab(4, 4, "B", hjust = 1.6, vjust = 1) +
    annotate("text", x = 5.5, y = 4.6, hjust = 0, size = 3.6, colour = macro_pal[["rouge"]],
             label = "Relance : A → B\n−2 points de chômage\ncontre +2 points d'inflation") +
    annotate("text", x = 9.9, y = 1.2, hjust = 1, vjust = 0, size = 3.6, fontface = "bold",
             colour = macro_pal[["bleu"]], label = "Courbe de Phillips\n(supposée stable)") +
    axes_phillips(c(3, 10), c(-1, 7))
}

# 2. Friedman sur le marché du travail. Les salariés offrent leur travail
#    selon le salaire réel qu'ils anticipent, W/P^a. Une hausse surprise
#    des prix (P > P^a) leur fait surestimer leur salaire réel : à salaire
#    réel effectif w = W/P donné, ils offrent davantage de travail.
#    L^d : w = 10 - 0,5 L ;  L^s (P^a = P) : w = 2 + 0,5 L  -> E0 (8 ; 6).
#    L^s' (P / P^a = 1,25) : w = (2 + 0,5 L) / 1,25        -> E1 (9,33 ; 5,33).
fig_friedman_travail <- function(stage = 3) {
  # stage 0 : équilibre initial E0 ; 1 : + déplacement de l'offre ;
  # 2 : + nouvel équilibre E1 ; 3 : + retour en E0 (anticipations corrigées).
  L <- seq(0, 16, length.out = 200)
  ecart <- 1.25
  e1_L <- 8.4 / 0.9
  e1_w <- 10 - 0.5 * e1_L
  df <- rbind(
    data.frame(L = L, w = 10 - 0.5 * L, courbe = "Ld"),
    data.frame(L = L, w = 2 + 0.5 * L, courbe = "Ls"),
    data.frame(L = L, w = (2 + 0.5 * L) / ecart, courbe = "Ls2")
  )
  if (stage < 1) df <- subset(df, courbe != "Ls2")

  p <- ggplot(df, aes(L, w, colour = courbe, linetype = courbe)) +
    geom_line(linewidth = 1.1) +
    annotate("segment", x = 8, xend = 8, y = 0, yend = 6,
             linetype = "dotted", colour = macro_pal[["gris"]]) +
    annotate("segment", x = 0, xend = 8, y = 6, yend = 6,
             linetype = "dotted", colour = macro_pal[["gris"]]) +
    annotate("text", x = 0.2, y = 6, label = "w*", hjust = 0, vjust = -0.4, size = 3.6) +
    annotate("text", x = 8, y = 0.2, label = "L*", hjust = 1.3, vjust = 0, size = 3.6) +
    annotate("text", x = 16.3, y = c(2, 10), hjust = 0, size = 3.6, fontface = "bold",
             colour = macro_pal[c("bleu", "rouge")], label = c("Ld", "Ls\n(Pª = P)"))

  if (stage >= 1) {
    p <- p +
      fleche(9.4, 6.5, 12, 6.5, macro_pal[["rouge"]]) +
      annotate("text", x = 10.7, y = 6.95, label = "1", size = 5, fontface = "bold",
               colour = macro_pal[["rouge"]]) +
      annotate("text", x = 16.3, y = 8, hjust = 0, size = 3.6, fontface = "bold",
               colour = macro_pal[["rouge"]], label = "Ls'\n(P > Pª)")
  }
  if (stage >= 2) {
    p <- p +
      annotate("segment", x = e1_L, xend = e1_L, y = 0, yend = e1_w,
               linetype = "dotted", colour = macro_pal[["gris"]]) +
      annotate("segment", x = 0, xend = e1_L, y = e1_w, yend = e1_w,
               linetype = "dotted", colour = macro_pal[["gris"]]) +
      annotate("text", x = 0.2, y = e1_w, label = "w1", hjust = 0, vjust = 1.3, size = 3.6) +
      annotate("text", x = e1_L, y = 0.2, label = "L1", hjust = -0.3, vjust = 0, size = 3.6) +
      annotate("text", x = e1_L + 1.3, y = e1_w - 0.9, label = "2", size = 5, fontface = "bold",
               colour = macro_pal[["rouge"]]) +
      point_lab(e1_L, e1_w, "E1", hjust = -0.4, vjust = 1.4, col = macro_pal[["rouge"]])
  }
  if (stage >= 3) {
    p <- p +
      fleche(e1_L - 0.25, e1_w + 0.15, 8.25, 5.9, macro_pal[["vert"]], lty = "dashed") +
      annotate("text", x = 8.6, y = 6.75, label = "3", size = 5, fontface = "bold",
               colour = macro_pal[["vert"]])
  }

  p +
    point_lab(8, 6, "E0", hjust = 1.4, vjust = -0.3) +
    scale_colour_manual(values = c(Ld = macro_pal[["bleu"]], Ls = macro_pal[["rouge"]],
                                   Ls2 = macro_pal[["rouge"]])) +
    scale_linetype_manual(values = c(Ld = "solid", Ls = "solid", Ls2 = "dashed")) +
    coord_cartesian(xlim = c(0, 19), ylim = c(0, 11), expand = FALSE, clip = "off") +
    scale_x_continuous(breaks = seq(0, 16, 4)) +
    labs(x = "Emploi (L)", y = "Salaire réel effectif (w = W/P)") +
    theme_macro() +
    theme(legend.position = "none")
}

# 3. L'accélération de l'inflation (anticipations adaptatives, pi_a = inflation
#    de la période précédente). L'État vise u = 5 % < u_n = 7 %.
#    stage 1 : A -> B le long de CT (pi_a = 0).
#    stage 2 : les anticipations s'ajustent (pi_a = 2) ; si la relance s'arrête,
#              retour en C, au NAIRU, avec 2 % d'inflation.
#    stage 3 : si l'État maintient u = 5 %, B -> D -> F : +2 points d'inflation
#              par période, l'inflation accélère.
fig_phillips_acceleration <- function(stage = 3) {
  u <- seq(3.5, 10, length.out = 100)
  pis <- c(0, 2, 4)[seq_len(stage)]
  df <- data.frame(u = rep(u, length(pis)), pi_a = rep(pis, each = length(u)))
  df$pi <- phil_ct(df$u, df$pi_a)
  cols <- c(macro_pal[["bleu"]], macro_pal[["bleu2"]], macro_pal[["or"]])[seq_len(stage)]
  labs_ct <- data.frame(u = 10.1, pi = phil_ct(10, pis), cols = cols,
                        lab = paste0("CT : inflation\nanticipée ", pis, " %"))

  p <- ggplot(df, aes(u, pi, group = pi_a)) +
    geom_vline(xintercept = phil_un, linetype = "dashed", colour = macro_pal[["vert"]], linewidth = 0.8) +
    annotate("text", x = phil_un + 0.1, y = 8.6, hjust = 0, size = 3.4, colour = macro_pal[["vert"]],
             label = "Long terme : u = uⁿ = 7 %") +
    geom_line(aes(colour = factor(pi_a)), linewidth = 1.1) +
    geom_text(data = labs_ct, aes(u, pi, label = lab), colour = labs_ct$cols, hjust = 0,
              size = 3.1, fontface = "bold", inherit.aes = FALSE) +
    scale_colour_manual(values = setNames(cols, pis)) +
    fleche(6.9, 0.1, 5.1, 1.9, macro_pal[["rouge"]]) +
    point_lab(7, 0, "A", hjust = -0.7, vjust = 0.8) +
    point_lab(5, 2, "B", hjust = 1.7, col = macro_pal[["rouge"]])

  if (stage >= 2) {
    p <- p +
      fleche(5.15, 2, 6.85, 2, macro_pal[["vert"]], lty = "dashed") +
      point_lab(7, 2, "C", hjust = -0.7, vjust = 1.1, col = macro_pal[["vert"]])
  }
  if (stage >= 3) {
    p <- p +
      fleche(5, 2.15, 5, 3.85, macro_pal[["rouge"]]) +
      fleche(5, 4.15, 5, 5.85, macro_pal[["rouge"]]) +
      point_lab(5, 4, "D", hjust = 1.7, col = macro_pal[["rouge"]]) +
      point_lab(5, 6, "F", hjust = 1.7, col = macro_pal[["rouge"]])
  }
  p + axes_phillips(c(3.5, 12.6), c(-4.5, 9))
}

# 4. Anticipations rationnelles. Hausse de l'inflation de 2 % à 5 %.
#    Anticipée : pi_a passe immédiatement à 5 %, A -> C, u reste à u_n.
#    Surprise : pi_a reste à 2 % un temps, A -> B (u = 4 %), puis B -> C
#    quand les agents révisent leurs anticipations.
fig_phillips_rationnelles <- function() {
  u <- seq(3, 10, length.out = 100)
  df <- data.frame(u = rep(u, 2), pi_a = rep(c(2, 5), each = length(u)))
  df$pi <- phil_ct(df$u, df$pi_a)

  ggplot(df, aes(u, pi, group = pi_a)) +
    geom_line(colour = macro_pal[["gris"]], linewidth = 0.8) +
    annotate("text", x = 10.1, y = phil_ct(10, c(2, 5)), hjust = 0, size = 3.1,
             colour = macro_pal[["gris"]], fontface = "bold",
             label = c("CT : inflation\nanticipée 2 %", "CT : inflation\nanticipée 5 %")) +
    geom_vline(xintercept = phil_un, linetype = "dashed", colour = macro_pal[["vert"]], linewidth = 0.8) +
    fleche(7, 2.15, 7, 4.85, macro_pal[["or"]]) +
    annotate("text", x = 7.15, y = 3.5, hjust = 0, size = 3.5, colour = macro_pal[["or"]],
             fontface = "bold", label = "Anticipée :\nA → C") +
    fleche(6.9, 2.1, 4.1, 4.9, macro_pal[["rouge"]]) +
    fleche(4.15, 5.15, 6.85, 5.15, macro_pal[["rouge"]], lty = "dashed") +
    annotate("text", x = 5.4, y = 5.75, size = 3.5, colour = macro_pal[["rouge"]],
             fontface = "bold", label = "Surprise : A → B → C") +
    point_lab(7, 2, "A", hjust = -0.7, vjust = 1.1) +
    point_lab(4, 5, "B", hjust = 1.7, col = macro_pal[["rouge"]]) +
    point_lab(7, 5, "C", hjust = -0.7, vjust = -0.3) +
    axes_phillips(c(3, 12.6), c(-1.5, 8))
}
