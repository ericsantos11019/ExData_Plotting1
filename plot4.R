plot4 <- function(data = NULL, png = TRUE)
{
  # Changes the current working directory to the folder containing this R
  # script. This ensures that the relative paths will work as intended.
  previousWD <- getwd()
  newWD <- getSrcDirectory(function(x) {x})
  setwd(newWD)
  
  # In case the 'readData()' function is still not loaded.
  sapply(c("readData.R", "plot2.R", "plot3.R"), source)
  
  # If the dataset is passed on as an argument, we don't need to read it again.
  if(is.null(data)) {
    data <- readData()
  }
  
  # If 'png = TRUE', then the plot will be saved to a PNG file. Otherwise,
  # to the screen canvas.
  if(png) png("plot4.png", bg = "transparent")
  
  # To ensure weekdays will show up properly.
  Sys.setlocale(locale = "en_US")
  
  # Merges 'Date' and 'Time' and converts the resulting string to a date
  # object.
  d <- strptime(paste(data$Date, data$Time), "%e/%m/%Y %T")
  
  # Plotting.
  par(mfrow = c(2, 2))
  
  # Top-left plot:
  plot2(data, png = FALSE)
  
  # Top-right plot:
  with(data, plot(d, Voltage, xlab = "Date/Time", ylab = "Voltage", type = "l"))
  
  # Bottom-left plot:
  plot3(data, png = FALSE, drawBox = FALSE)
  
  # Bottom-right plot:
  with(data, plot(d, Global_reactive_power, xlab = "Date/Time", 
                  ylab = "Global Reactive Power", type = "l"))
  
  # If the plot is exported to a file, then we have to close the device.
  if(png) dev.off()
  
  # Finally, once done, returns to the previous working directory.
  setwd((previousWD))
}