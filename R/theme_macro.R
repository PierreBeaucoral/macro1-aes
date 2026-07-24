# ------------------------------------------------------------------
# Thème ggplot commun + palette pour toutes les figures du cours.
# Chargé par les chunks R des .qmd :  source(here::here("R/theme_macro.R"))
# ------------------------------------------------------------------
suppressPackageStartupMessages({
  library(ggplot2)
})

# Palette cohérente avec le site (bleu ardoise + accents)
macro_pal <- c(
  bleu   = "#1f4e79",
  or     = "#b8860b",
  rouge  = "#b5303a",
  vert   = "#2e7d5b",
  gris   = "#6c757d",
  bleu2  = "#5b8fb9"
)

theme_macro <- function(base_size = 13) {
  theme_minimal(base_size = base_size) +
    theme(
      plot.title      = element_text(face = "bold", color = "#1f4e79", size = rel(1.05)),
      plot.subtitle   = element_text(color = "#444444"),
      axis.title      = element_text(face = "bold"),
      panel.grid.minor = element_blank(),
      panel.grid.major = element_line(color = "grey88"),
      legend.position = "bottom",
      legend.title    = element_blank(),
      plot.margin     = margin(6, 10, 6, 6)
    )
}

# Aide : flèche d'axe orienté (pour schémas offre/demande, OA-DA, etc.)
axes_fleches <- function() {
  list(
    geom_segment(aes(x = 0, xend = Inf, y = 0, yend = 0),
                 arrow = arrow(length = unit(.18, "cm")), linewidth = .4),
    geom_segment(aes(x = 0, xend = 0, y = 0, yend = Inf),
                 arrow = arrow(length = unit(.18, "cm")), linewidth = .4)
  )
}
