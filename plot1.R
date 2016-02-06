plot1 <- function(data = NULL, png = TRUE)
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
  if(png) png("plot1.png", bg = "transparent")
  
  # Plotting.
  with(data, hist(Global_active_power, xlab = "Global Active Power (kilowatts)",
       col = "red", main = "Global Active Power"))
  
  # If the plot is exported to a file, then we have to close the device.
  if(png) dev.off()
  
  # Finally, once done, returns to the previous working directory.
  setwd((previousWD))
}