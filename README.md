# Car-Data
## Contributors
Hannah Maurer, Logan Schulz, Tsion Nigate, and Reid McNeill
## Introduction
For this project, we sat at the radar detector and recorded the date, time, speed, orange light, license plate by state, weather, and temperature of the different cars passing through. 

## Dictionary
- Radar detector located near 30th St and 24th Avenue in Rock Island IL
- Collected at least 50 cars per person(totaling more than 200)

## Installation of Required Packages:
-Made sure we had the following R packages installed: ggplot2, shiny, DT, readxl.

## Data Preparation:
-Made sure the location of our speed data in an Excel file named "MergedCarData.xlsx".
-The Excel file contained a column named "Speed".
```
library(ggplot2)
library(shiny)
library(DT)
library(readxl)
```
## Data Organization
1. We started by merging our data into one Excel file.
   
## Running the Shiny App:
-We set our working directory to the location where the "MergedCarData.xlsx" file is located.
-Run the provided R code in RStudio or any other R environment.
### UI (User Interface):
   The user interface of the Speed Analysis Shiny app is designed using the fluidPage() function from the Shiny package.
   It provides an interactive environment for users to explore and analyze speed data. Key components of the UI include:
  ```
  ui <- fluidPage(
    titlePanel("Speed Analysis")
    
    fluidRow(
      column(2,
             selectInput("X", "Choose X", column_names, column_names[1]),
             selectInput("Y", "Choose Y", column_names, column_names[3]),
             selectInput("Splitby", "Split By", column_names, column_names[3])),
      column(4, plotOutput("plot_01")),
      column(6, DT::dataTableOutput("table_01", width = "100%"))
    ),
 ```
1. Dropdown Menus:
-Users can select variables (X, Y, Split By) for analysis using dropdown menus. The menus allows customization of the data displayed in the plots and tables.

2. Plot Area:
The app includes a plot area where users can visualize their selected variables. Scatter plots with customizable axes and colors are generated based on user input.

3. Data Table:
A data table is provided to display the raw data. Users can view detailed information about the dataset, including the selected variables and their corresponding values.

4. Statistics Panels:
Panels for displaying statistics such as minimum, maximum, median, and mean speeds are included in the main panel. These statistics are dynamically calculated based on the selected data.

### Server Logic:

 ```
server <- function(input, output) {
  
  calculate_stats <- function(data) {
    speed <- data$Speed
    min_val <- min(speed)
    max_val <- max(speed)
    median_val <- median(speed)
    mean_val <- round(mean(speed), digits = 0)  # Round mean to whole number
    return(list(min = min_val, max = max_val, median = median_val, mean = mean_val, speeds = speed))
  }
 ```
1. Calculating Statistics:
The server calculates statistics (minimum, maximum, median, mean) of the speed data based on user input and renders them dynamically in the UI.

2. Generating Plots:
Interactive scatter plots and histograms are generated based on user-selected variables. These plots provide visual insights into the distribution and relationships within the data.

3. Displaying Data Table:
The server logic also includes rendering the data table, allowing users to view the raw data in a tabular format with customizable page length.

### Shiny Results with Chart
```
 mainPanel(
    h3("Results:"),
    verbatimTextOutput("min"),
    verbatimTextOutput("max"),
    verbatimTextOutput("median"),
    verbatimTextOutput("mean"),
    plotOutput("histogram"),
```
-Shiny displayed the following statistics about the speed data:
  Minimum speed
  Maximum speed
  Median speed
  Mean speed
-Additionally, it generated a histogram and a plot visualizing the distribution of speeds.

### Enbeded google doc 
-We added our 500 word project explanation as a google doc and embeded it in the shiny app.
```
  output$embedded_google_doc <- renderUI({
    tags$iframe(src = "https://docs.google.com/document/d/e/2PACX-1vRhCNegGM4QeYxBCwWis_OtrCnh5_ImYbjNII3xtDKZRO-YkUh2MdSzPwJGlPqAWmqgET9pqggWl9xX/pub?embedded=true",
                width = "100%", height = 600)
```

## Conclusion 
- Insert charts here :)
  
- [applink]([https://www.example.com](https://tsionnigate21.shinyapps.io/Ncar/))
