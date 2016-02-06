plot3 <- function(data = NULL, png = TRUE, drawBox = TRUE)
{
  # Changes the current working directory to the folder containing this R
  # script. This ensures that the relative paths will work as intended.
  previousWD <- getwd()
  newWD <- getSrcDirectory(function(x) {x})
  setwd(newWD)
  
  # In case the 'readData()' function is still not loaded.
  source("readData.R")
  
  # If the dataset is passed on as an argument, we don't need to read it again.
  if(is.null(data)) {
    data <- readData()
  }
  
  # If 'png = TRUE', then the plot will be saved to a PNG file. Otherwise,
  # to the screen canvas.
  if(png) png("plot3.png", bg = "transparent")
  
  # To ensure weekdays will show up properly.
  Sys.setlocale(locale = "en_US")
  
  # Merges 'Date' and 'Time' and converts the resulting string to a date
  # object.
  d <- strptime(paste(data$Date, data$Time), "%e/%m/%Y %T")
  
  # Plotting.
  with(data, {
    plot(d, Sub_metering_1, xlab = "", type = "l", ylab = "Energy sub metering")
    lines(d, Sub_metering_2, col = "red")
    lines(d, Sub_metering_3, col = "blue")
  })
  if(drawBox) b <- "o" else b <- "n"
  legend("topright", col = c("black", "red", "blue"), lty = 1,
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
         bty = b)
  
  # If the plot is exported to a file, then we have to close the device.
  if(png) dev.off()
  
  # Finally, once done, returns to the previous working directory.
  setwd((previousWD))
}