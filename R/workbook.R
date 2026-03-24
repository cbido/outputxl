#' Create a Pre-Configured Workbook
#'
#' Creates an `openxlsx` workbook with optional metadata.
#'
#' @param creator Character. Name of the workbook author.
#'   Default `"outputxl"`.
#' @param title Character or NULL. Optional workbook title stored in
#'   document properties.
#' @return An `openxlsx` workbook object, ready for use with [sxl_write()]
#'   and [sxl_write_sheet()].
#' @examples
#' wb <- sxl_workbook(creator = "Research Team",
#'                    title = "Household Survey Analysis")
#' @export
sxl_workbook <- function(creator = "outputxl", title = NULL) {
  openxlsx::createWorkbook(creator = creator, title = title)
}


#' Save a Workbook
#'
#' A thin wrapper around [openxlsx::saveWorkbook()] that prints a
#' confirmation message with the file path and sheet count.
#'
#' @param wb An `openxlsx` workbook object.
#' @param path Character. File path for the output `.xlsx`.
#' @param overwrite Logical. Overwrite existing file? Default TRUE.
#' @return The file path (invisible).
#' @examples
#' \dontrun{
#' wb <- sxl_workbook()
#' addWorksheet(wb, "Demo")
#' sxl_save(wb, "output.xlsx")
#' }
#' @export
sxl_save <- function(wb, path, overwrite = TRUE) {
  openxlsx::saveWorkbook(wb, path, overwrite = overwrite)
  sheets <- length(openxlsx::sheets(wb))
  message("Saved: ", path, " (", sheets, " sheet", if (sheets != 1) "s", ")")
  invisible(path)
}
