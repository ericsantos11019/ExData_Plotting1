readData <- function()
{
  require(data.table, warn.conflicts = FALSE)
  
  # Changes the working directory to the folder containing this R script. This
  # ensures that the relative paths will work as intended.
  previousWD <- getwd()
  newWD <- getSrcDirectory(function(x) {x})
  setwd(newWD)

  zipFileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  zipFile <- tempfile()
  
  # The compressed (ZIP) file contianing the dataset is downloaded to a
  # temporary file and is disposed of later.
  message("- Downloading Data File...")
  download.file(zipFileUrl, zipFile, method = "curl", quiet = TRUE)
  message("- Data File Downloaded.")
  
  # Once the donwload is complete, extracts the full dataset (in the TXT format)
  # from the ZIP file. The 'unzip()' function copies the files to the working
  # directory, so we need to remove it later.
  message("- Unzipping Data...")
  dataFile <- unzip(zipFile)
  message("- Data Unzipped.")
  
  # Once the TXT dataset file is unzipped, we read the data using the 'fred()'
  # function from the 'data.table' package. To avoid the memory overhead and
  # speed up the code, we start reading at the row with the first occurrence of 
  # "1/2/2007". Once the proper row is found, the code starts reading the file
  # from that point and reads 2880 lines (60 minutes x 24 hours x 2 days), i.e. 
  # two fulll days. However, since we skip to the middle of the TXT file, the 
  # column names are skipped too. To solve that, we read the just the first row
  # of the data again and assign the column names to the full data table.
  message("- Loading Data...")
  data <- fread(dataFile, na.strings = "?", skip = "1/2/2007", nrows = 2880)
  header <- fread(dataFile, na.strings = "?", nrows = 1)
  setnames(data, names(data), names(header))
  message("- Finished Loading Data.")
  
  # Once we are done with the files, we can remove them.
  unlink(zipFile)
  unlink(dataFile)
  
  # Once we are done with processing, we can go back to the previous working
  # directory.
  setwd(previousWD)
  
  return(data)
}