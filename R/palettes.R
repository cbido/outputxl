#' Institutional Color Palettes
#'
#' Pre-defined color palettes following institutional branding guidelines
#' for international development and social protection agencies.
#'
#' @param palette Character. Name of the palette to use.
#'   Available palettes: `"un_blue"`, `"unfpa"`, `"undp"`, `"unicef"`,
#'   `"world_bank"`, `"eclac"`, `"neutral"`.
#' @return A named list with elements: `primary`, `light`, `white`,
#'   `accent`, `border`, `total_fill`, `title_color`.
#' @examples
#' pal <- sxl_palette("unfpa")
#' pal$primary
#' # "#3571A4"
#'
#' pal <- sxl_palette("world_bank")
#' pal$accent
#' # "#F05023"
#' @export
sxl_palette <- function(palette = "un_blue") {
  palettes <- list(

    # UN system blue — generic United Nations branding
    # Source: UN Brand Identity Quick Guide (2020), Pantone 2925 / #009EDB
    un_blue = list(
      primary    = "#009EDB",
      light      = "#E0F3FB",
      white      = "#FFFFFF",
      accent     = "#FFC20E",
      border     = "#CCCCCC",
      total_fill = "#B3DFF0",
      title_color = "#005B8E"
    ),

    # UNFPA — United Nations Population Fund
    # Source: brandcolorcode.com/unfpa
    # Blue: #3571A4, Orange: #E38A15
    unfpa = list(
      primary    = "#3571A4",
      light      = "#E4EFF7",
      white      = "#FFFFFF",
      accent     = "#E38A15",
      border     = "#CCCCCC",
      total_fill = "#C5D9EA",
      title_color = "#3571A4"
    ),

    # UNDP — United Nations Development Programme
    # Source: brandcolorcode.com/undp
    # Blue: #0468B1
    undp = list(
      primary    = "#0468B1",
      light      = "#E3F0FA",
      white      = "#FFFFFF",
      accent     = "#E5243B",
      border     = "#CCCCCC",
      total_fill = "#C5DCEE",
      title_color = "#0468B1"
    ),

    # UNICEF — United Nations Children's Fund
    # Source: official brand guide; #1CABE2
    unicef = list(
      primary    = "#1CABE2",
      light      = "#E0F4FC",
      white      = "#FFFFFF",
      accent     = "#FFC20E",
      border     = "#CCCCCC",
      total_fill = "#B8E3F5",
      title_color = "#00233F"
    ),

    # World Bank Group
    # Source: WBG Branding and Visual Identity Guidelines (2017)
    # Navy: #002244, Accent orange: #F05023
    world_bank = list(
      primary    = "#002244",
      light      = "#E8EDF2",
      white      = "#FFFFFF",
      accent     = "#F05023",
      border     = "#CCCCCC",
      total_fill = "#CDD5DD",
      title_color = "#002244"
    ),

    # ECLAC/CEPAL — Economic Commission for Latin America and the Caribbean
    # Source: brandfetch.com/eclac.org
    # Blue: #036BAA, Accent: #A03030
    eclac = list(
      primary    = "#036BAA",
      light      = "#E0ECF5",
      white      = "#FFFFFF",
      accent     = "#A03030",
      border     = "#CCCCCC",
      total_fill = "#C0D6E8",
      title_color = "#036BAA"
    ),

    # Neutral — for academic, independent, or non-branded outputs
    neutral = list(
      primary    = "#2C3E50",
      light      = "#ECF0F1",
      white      = "#FFFFFF",
      accent     = "#E67E22",
      border     = "#BDC3C7",
      total_fill = "#D5DBDB",
      title_color = "#2C3E50"
    )
  )

  if (!palette %in% names(palettes)) {
    stop(
      "Unknown palette '", palette, "'. Available: ",
      paste(names(palettes), collapse = ", "),
      call. = FALSE
    )
  }

  palettes[[palette]]
}
