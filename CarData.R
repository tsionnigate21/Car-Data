library(ggplot2)
library(shiny)
library(DT)
library(readxl)

#setwd('C:/Users/stick/Documents/GitHub/Car-Data')
dir.create('data')

df <- data.frame()

capitalize_words <- function(word_list) {
  sapply(word_list, function(word) {
    paste(toupper(substring(word, 1, 1)), substring(word, 2), sep = "")
  })
}
download <- function(name) {
  url <- "https://github.com/LoJoSho/Car-Data/raw/main/"
  download.file(paste0(url, name), paste0("data/", name), quiet = TRUE)
}

# ABBA Data
download("MergedCarData.csv")
abba_data <- read.csv('data/MergedCarData.csv')
df <- rbind(df, abba_data)

# Assign Values
df$Date <- as.Date(df$Date)
df$Time <- as.Date(df$Date)
df$Speed <- as.numeric(df$Speed)
df$Orange.Light <- as.logical(df$Orange.Light)
df$Temperature <- as.numeric(df$Temperature)

# Clean all the data
df$State <- replace(df$State, df$State == 'IO', 'IA') # Fix IA being IO
df$Weather <- capitalize_words(df$Weather) # Make first letter capitalize
df$Time <- format(df$Time, "%H:%M:%S")

ui <- fluidPage(
  
  # Application title
  titlePanel("Speed Analysis"),
  
  # Output: Results displayed in main panel
  mainPanel(
    h3("Results:"),
    verbatimTextOutput("min"),
    verbatimTextOutput("max"),
    verbatimTextOutput("median"),
    verbatimTextOutput("mean"),
    plotOutput("histogram")
  )
)

# Define server logic
server <- function(input, output) {
  calculate_stats <- function(data) {
    speed <- data$Speed
    min_val <- min(speed)
    max_val <- max(speed)
    median_val <- median(speed)
    mean_val <- round(mean(speed), digits = 0)  # Round mean to whole number
    return(list(min = min_val, max = max_val, median = median_val, mean = mean_val, speeds = speed))
  }
  
  # Calculate statistics and render outputs
  output$min <- renderPrint({ paste("Minimum Speed:", calculate_stats(df)$min) })
  output$max <- renderPrint({ paste("Maximum Speed:", calculate_stats(df)$max) })
  output$median <- renderPrint({ paste("Median Speed:", calculate_stats(df)$median) })
  output$mean <- renderPrint({ paste("Mean Speed:", calculate_stats(df)$mean) })
  output$histogram <- renderPlot({
    speeds <- calculate_stats(df)$speeds
    hist(speeds, main = "Distribution of Speeds", xlab = "Speed", ylab = "Frequency", col = "skyblue")
  })
}

# Run the application
shinyApp(ui, server)
