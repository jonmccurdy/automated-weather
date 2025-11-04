# get_emmitsburg_temp.R

library(httr)
library(jsonlite)
library(readr)

res <- GET("https://api.weather.gov/stations/KHGR/observations/latest")
data <- fromJSON(content(res, "text", encoding = "UTF-8"))

temp_c <- data$properties$temperature$value
temp_f <- temp_c * 9/5 + 32

df <- data.frame(time = Sys.time(), station = "KHGR", temp_c = temp_c, temp_f = temp_f)

dir.create("data", showWarnings = FALSE)
file <- "data/emmitsburg_weather.csv"

if (file.exists(file)) {
  write_csv(df, file, append = TRUE)
} else {
  write_csv(df, file)
}