#' Build openxlsx Styles from a Palette
#'
#' Creates a set of consistently styled `openxlsx` style objects for
#' titles, headers, alternating rows, TOTAL rows, and number formats.
#'
#' @param palette Character or list. Either a palette name recognized by
#'   [sxl_palette()], or a named list with the same structure.
#' @param font_name Character. Font family to use across all styles.
#'   Default `"Calibri"`.
#' @param font_size_title Numeric. Font size for section titles. Default 12.
#' @param font_size_body Numeric. Font size for data cells. Default 11.
#' @return A named list of `openxlsx` style objects:
#'   `title`, `header`, `row_odd`, `row_even`, `total`, `number`, `percent`.
#' @examples
#' styles <- sxl_styles("unfpa")
#' styles$header
#' @export
sxl_styles <- function(palette = "un_blue",
                       font_name = "Calibri",
                       font_size_title = 12,
                       font_size_body = 11) {

  pal <- if (is.character(palette)) sxl_palette(palette) else palette

  list(
    title = openxlsx::createStyle(
      fontColour  = pal$title_color,
      fontSize    = font_size_title,
      fontName    = font_name,
      textDecoration = "bold"
    ),

    header = openxlsx::createStyle(
      fontColour  = pal$white,
      fgFill      = pal$primary,
      fontSize    = font_size_body,
      fontName    = font_name,
      halign      = "center",
      valign      = "center",
      textDecoration = "bold",
      border      = "TopBottomLeftRight",
      borderColour = pal$primary
    ),

    row_odd = openxlsx::createStyle(
      fgFill      = pal$white,
      fontSize    = font_size_body,
      fontName    = font_name,
      halign      = "left",
      valign      = "center",
      border      = "TopBottomLeftRight",
      borderColour = pal$border
    ),

    row_even = openxlsx::createStyle(
      fgFill      = pal$light,
      fontSize    = font_size_body,
      fontName    = font_name,
      halign      = "left",
      valign      = "center",
      border      = "TopBottomLeftRight",
      borderColour = pal$border
    ),

    total = openxlsx::createStyle(
      fgFill      = pal$total_fill,
      fontSize    = font_size_body,
      fontName    = font_name,
      halign      = "left",
      valign      = "center",
      textDecoration = "bold",
      border      = "TopBottomLeftRight",
      borderColour = pal$primary
    ),

    number = openxlsx::createStyle(
      halign = "right",
      numFmt = "#,##0"
    ),

    percent = openxlsx::createStyle(
      halign = "right",
      numFmt = "0.0%"
    )
  )
}
