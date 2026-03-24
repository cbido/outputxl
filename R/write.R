#' Write a Formatted Table to an Excel Sheet
#'
#' Writes a data frame to an existing worksheet with institutional styling:
#' branded header row, alternating row shading, automatic TOTAL row detection,
#' and auto-width columns. Multiple tables can be stacked on the same sheet
#' by chaining calls and passing the returned row position forward.
#'
#' @param wb An `openxlsx` workbook object.
#' @param sheet Character. Name of the worksheet (must already exist in `wb`).
#' @param data A data frame to write.
#' @param start_row Integer. Row to begin writing. Default 1.
#' @param title Character or NULL. Optional section title placed above the table.
#' @param styles A styles list from [sxl_styles()]. If NULL, default styles are
#'   generated automatically.
#' @param gap Integer. Number of blank rows to leave after the table for
#'   stacking. Default 2.
#' @param total_keywords Character vector. Values in the first column that
#'   trigger TOTAL-row styling. Default `c("TOTAL", "Total", "SUBTOTAL")`.
#' @param freeze Logical. Whether to freeze the header row. Default TRUE.
#' @param auto_width Logical. Whether to auto-fit column widths. Default TRUE.
#' @return Integer. The next available row for writing (invisible), enabling
#'   chaining like `row <- sxl_write(wb, "Sheet1", df1, 1); sxl_write(wb, "Sheet1", df2, row)`.
#' @examples
#' library(openxlsx)
#' wb <- createWorkbook()
#' addWorksheet(wb, "Demo")
#'
#' df <- data.frame(
#'   Category = c("Group A", "Group B", "TOTAL"),
#'   N = c(150, 250, 400),
#'   Pct = c(37.5, 62.5, 100.0)
#' )
#'
#' row <- sxl_write(wb, "Demo", df, title = "DISTRIBUTION BY GROUP")
#' @export
sxl_write <- function(wb, sheet, data,
                      start_row = 1,
                      title = NULL,
                      styles = NULL,
                      gap = 2,
                      total_keywords = c("TOTAL", "Total", "SUBTOTAL", "Subtotal"),
                      freeze = TRUE,
                      auto_width = TRUE) {

  if (is.null(styles)) styles <- sxl_styles()

  current_row <- start_row

  if (!is.null(title)) {
    openxlsx::writeData(wb, sheet, title, startRow = current_row, startCol = 1)
    openxlsx::addStyle(wb, sheet, style = styles$title, rows = current_row, cols = 1)
    current_row <- current_row + 1
  }

  header_row <- current_row

  openxlsx::writeData(
    wb, sheet, data,
    startRow  = current_row,
    startCol  = 1,
    headerStyle = styles$header
  )

  n_rows <- nrow(data)
  n_cols <- ncol(data)

  for (i in seq_len(n_rows)) {
    row_idx   <- current_row + i
    first_val <- as.character(data[[1]][i])
    is_total  <- !is.na(first_val) && trimws(first_val) %in% total_keywords

    if (is_total) {
      style_to_apply <- styles$total
    } else if (i %% 2 == 1) {
      style_to_apply <- styles$row_odd
    } else {
      style_to_apply <- styles$row_even
    }

    openxlsx::addStyle(
      wb, sheet,
      style = style_to_apply,
      rows = row_idx,
      cols = 1:n_cols,
      gridExpand = TRUE
    )
  }

  if (auto_width) {
    openxlsx::setColWidths(wb, sheet, cols = 1:n_cols, widths = "auto")
  }

  if (freeze) {
    openxlsx::freezePane(
      wb, sheet,
      firstActiveRow = header_row + 1,
      firstActiveCol = 2
    )
  }

  invisible(current_row + n_rows + 1 + gap)
}


#' Write a Formatted Table to a New Dedicated Sheet
#'
#' A convenience wrapper that creates a new worksheet and writes a single
#' formatted table to it. Useful for the common pattern of one-table-per-sheet.
#'
#' @inheritParams sxl_write
#' @param sheet_name Character. Name of the new worksheet to create.
#' @return The workbook object `wb` (invisible), for pipe-friendly chaining.
#' @examples
#' library(openxlsx)
#' wb <- createWorkbook()
#'
#' df <- data.frame(
#'   Region = c("North", "South", "East", "TOTAL"),
#'   Households = c(5000, 3200, 2800, 11000),
#'   Pct_Poverty = c(45.2, 61.8, 38.5, 48.9)
#' )
#'
#' sxl_write_sheet(wb, "Poverty_Regional", df,
#'                 title = "POVERTY RATE BY REGION")
#' @export
sxl_write_sheet <- function(wb, sheet_name, data,
                            title = NULL,
                            styles = NULL,
                            total_keywords = c("TOTAL", "Total", "SUBTOTAL", "Subtotal"),
                            auto_width = TRUE) {

  openxlsx::addWorksheet(wb, sheet_name)

  sxl_write(
    wb, sheet_name, data,
    start_row      = 1,
    title          = title,
    styles         = styles,
    total_keywords = total_keywords,
    freeze         = TRUE,
    auto_width     = auto_width
  )

  invisible(wb)
}
