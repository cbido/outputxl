# outputxl

> Institutional-styled Excel outputs for survey analysis — one function call, publication-ready tables.

[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

## The problem

If you work with household survey data for government agencies or international organizations, you know the cycle: run the analysis in R, export to Excel, then spend hours manually formatting headers, alternating row colors, bolding TOTAL rows, and matching institutional branding. Every deliverable, every time.

**outputxl** eliminates that step. One function call takes a data frame and returns a publication-ready Excel table with branded colors, alternating rows, auto-detected TOTAL rows, freeze panes, and auto-fit columns.

## Installation

```r
# install.packages("remotes")
remotes::install_github("cbido/outputxl")
```

## Quick start

```r
library(outputxl)
library(openxlsx)

df <- data.frame(
  Region = c("North", "Central", "South", "East", "TOTAL"),
  Households = c(5612, 3847, 1891, 1654, 13004),
  Poverty_Rate = c(42.3, 61.8, 55.1, 48.7, 50.6)
)

wb <- sxl_workbook()
sxl_write_sheet(wb, "Poverty", df, title = "POVERTY RATE BY REGION")
sxl_save(wb, "report.xlsx")
```

The TOTAL row is auto-detected and bolded with a distinct fill. Headers match your chosen palette. Rows alternate. Columns auto-size. Pane is frozen.

## Stacking multiple tables on one sheet

`sxl_write()` returns the next available row, so you can chain tables vertically:

```r
wb <- sxl_workbook()
addWorksheet(wb, "Demographics")

row <- sxl_write(wb, "Demographics", pop_table, title = "POPULATION BY AGE GROUP")
row <- sxl_write(wb, "Demographics", hh_table, start_row = row, title = "HOUSEHOLD COMPOSITION")
row <- sxl_write(wb, "Demographics", dep_table, start_row = row, title = "DEPENDENCY RATIOS")

sxl_save(wb, "demographics.xlsx")
```

## Palettes

Seven built-in palettes with verified institutional colors:

| Palette | Primary | Accent | Source |
|---------|---------|--------|--------|
| `un_blue` | #009EDB | #FFC20E | UN Brand Identity Quick Guide (2020) |
| `unfpa` | #3571A4 | #E38A15 | UNFPA logo / brand guide |
| `undp` | #0468B1 | #E5243B | UNDP brand guide |
| `unicef` | #1CABE2 | #FFC20E | UNICEF brand guide |
| `world_bank` | #002244 | #F05023 | WBG Visual Identity Guidelines (2017) |
| `eclac` | #036BAA | #A03030 | ECLAC/CEPAL brand assets |
| `neutral` | #2C3E50 | #E67E22 | General-purpose academic |

```r
# Switch palettes
styles_unfpa <- sxl_styles("unfpa")
sxl_write_sheet(wb, "UNFPA_Table", df, title = "ANALYSIS", styles = styles_unfpa)

# Or use a custom palette
my_pal <- list(
  primary = "#1B4332", light = "#D8F3DC", white = "#FFFFFF",
  accent = "#D4A373", border = "#CCCCCC", total_fill = "#B7E4C7",
  title_color = "#1B4332"
)
sxl_write_sheet(wb, "Custom", df, styles = sxl_styles(my_pal))
```

## TOTAL row detection

Any row whose first column matches `total_keywords` gets distinct styling automatically. Defaults catch `"TOTAL"`, `"Total"`, `"SUBTOTAL"`, `"Subtotal"`. Extend as needed:

```r
sxl_write(wb, "Sheet1", df,
          total_keywords = c("TOTAL", "Total", "SUBTOTAL", "Average", "Mean"))
```

## Full workflow example

```r
library(outputxl)
library(openxlsx)

wb <- sxl_workbook(creator = "Research Unit",
                   title = "Household Survey Statistical Annex")

# Stacked tables on one sheet
addWorksheet(wb, "Demographics")
row <- sxl_write(wb, "Demographics", pop_by_age, title = "POPULATION BY AGE AND SEX")
row <- sxl_write(wb, "Demographics", housing, start_row = row, title = "HOUSING CONDITIONS")
row <- sxl_write(wb, "Demographics", vulnerability, start_row = row,
                 title = "ACCUMULATED VULNERABILITY CONDITIONS")

# One-table-per-sheet
sxl_write_sheet(wb, "Poverty_Index", poverty_table,
                title = "MULTIDIMENSIONAL POVERTY BY MUNICIPALITY")

# Different palette for a partner deliverable
styles_wb <- sxl_styles("world_bank")
sxl_write_sheet(wb, "WB_Format", poverty_table,
                title = "POVERTY INDICATORS", styles = styles_wb)

sxl_save(wb, "statistical_annex.xlsx")
```

## API reference

| Function | Purpose |
|----------|---------|
| `sxl_palette()` | Get a named color palette |
| `sxl_styles()` | Build openxlsx styles from a palette |
| `sxl_write()` | Write formatted table to existing sheet (returns next row) |
| `sxl_write_sheet()` | Create sheet + write one table |
| `sxl_workbook()` | Create workbook with metadata |
| `sxl_save()` | Save with confirmation |

## Background

This package extracts a formatting system originally embedded in large R analysis scripts (~5,000+ lines) producing multi-sheet Excel workbooks for household survey analysis deliverables. Rather than copy-pasting formatting code across projects, it wraps the pattern into a reusable, palette-aware package.

The design was shaped by the needs of social science consultants who produce statistical annexes, dossiers, and analytical reports for government social protection agencies and UN bodies — where institutional branding, consistent formatting, and clearly distinguished summary rows are not optional.

## Contributing

Issues and PRs welcome. If you work with a different institutional palette and want to add it, open a PR with the verified hex codes and the source.

## License

MIT
