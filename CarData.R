library(ggplot2)
library(shiny)
library(DT)
library(readxl)

setwd('C:/Users/hanna/Documents/DATA 332/CarData')
df <- read_excel('MergedCarData.xlsx', .name_repair = 'universal')

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
  
  # Function to calculate min, max, median, and mean from Excel sheet
  calculate_stats <- function(file_path) {
    # Read data from Excel file
    data <- read_excel(file_path)
    # Extract 'Speed' column
    speed <- data$Speed
    min_val <- min(speed)
    max_val <- max(speed)
    median_val <- median(speed)
    mean_val <- round(mean(speed), digits = 0)  # Round mean to whole number
    return(list(min = min_val, max = max_val, median = median_val, mean = mean_val, speeds = speed))
  }
  
  # Define the file path of the Excel file
  df <- "MergedCarData.xlsx"  # Update with your file path
  
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
shinyApp(ui = ui, server = server)
