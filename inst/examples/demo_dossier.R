# =============================================================================
# outputxl — Example: Multi-Palette Survey Dossier
# =============================================================================
#
# This script demonstrates the core outputxl workflow:
# - Stacking multiple tables on one sheet
# - One-table-per-sheet convenience function
# - Switching between institutional palettes
# - Custom palette support
#
# All data in this example is synthetic.

library(outputxl)
library(openxlsx)

# --- Synthetic survey data ---

pop_by_age <- data.frame(
  Age_Group = c("0-4", "5-14", "15-29", "30-44", "45-59", "60+", "TOTAL"),
  Male = c(1820, 3415, 5102, 3890, 2640, 1980, 18847),
  Female = c(1750, 3280, 5340, 4120, 2810, 2153, 19453),
  Total = c(3570, 6695, 10442, 8010, 5450, 4133, 38300),
  Pct = c(9.3, 17.5, 27.3, 20.9, 14.2, 10.8, 100.0),
  check.names = FALSE
)

poverty_index <- data.frame(
  Municipality = c("Municipality A", "Municipality B", "Municipality C",
                   "Municipality D", "Municipality E", "TOTAL"),
  Households = c(5612, 3847, 1891, 1654, 1020, 16024),
  Level_1 = c(1205, 1402, 612, 510, 389, 4118),
  Level_2 = c(1870, 1218, 540, 425, 312, 4365),
  Level_3 = c(2537, 1227, 739, 719, 319, 5541),
  Pct_Vulnerable = c(54.8, 68.1, 60.9, 56.5, 68.7, 52.9),
  check.names = FALSE
)

housing <- data.frame(
  Indicator = c("Dirt floor", "Overcrowding", "No potable water",
                "No sanitation", "Precarious roofing"),
  Households = c(1245, 2310, 890, 1560, 3420),
  Pct = c(7.8, 14.4, 5.6, 9.7, 21.3),
  check.names = FALSE
)

# --- Build workbook ---

wb <- sxl_workbook(creator = "Research Team",
                   title = "Household Survey Statistical Annex")

# Sheet 1: Stacked tables (default palette)
addWorksheet(wb, "Demographics")
row <- sxl_write(wb, "Demographics", pop_by_age,
                 title = "POPULATION BY AGE GROUP AND SEX")
row <- sxl_write(wb, "Demographics", housing,
                 start_row = row, title = "HOUSING CONDITIONS")

# Sheet 2: One table, default palette
sxl_write_sheet(wb, "Poverty_Index", poverty_index,
                title = "VULNERABILITY INDEX BY MUNICIPALITY")

# Sheets 3-8: Same data, different palettes
for (pal in c("un_blue", "unfpa", "undp", "unicef", "world_bank", "eclac")) {
  sxl_write_sheet(
    wb,
    sheet_name = paste0("Poverty_", pal),
    data = poverty_index,
    title = paste0("VULNERABILITY INDEX — ", toupper(pal), " PALETTE"),
    styles = sxl_styles(pal)
  )
}

sxl_save(wb, "demo_outputxl.xlsx")
