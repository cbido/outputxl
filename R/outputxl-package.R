#' outputxl: Institutional-Styled Excel Outputs for Survey Analysis
#'
#' Produces professionally formatted Excel workbooks from data analysis
#' outputs, following institutional styling conventions used by
#' international development organizations and government agencies.
#'
#' @section Core functions:
#' \describe{
#'   \item{[sxl_write()]}{Write a formatted table to an existing sheet (stackable)}
#'   \item{[sxl_write_sheet()]}{Create a new sheet and write one table to it}
#'   \item{[sxl_workbook()]}{Create a pre-configured workbook}
#'   \item{[sxl_save()]}{Save with confirmation message}
#' }
#'
#' @section Styling:
#' \describe{
#'   \item{[sxl_palette()]}{Institutional color palettes (UNFPA, UNDP, UNICEF, etc.)}
#'   \item{[sxl_styles()]}{Build openxlsx style objects from a palette}
#' }
#'
#' @docType package
#' @name outputxl-package
"_PACKAGE"
