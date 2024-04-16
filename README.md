# Car-Data
## Contributors
Hannah Maurer, Logan Schulz, Tsion Nigate, and Reid McNeill
## Introduction
For this project, we sat at the radar detector and recorded the date, time, speed, orange light, license plate by state, weather, and temperature of the different cars passing through. 
## Dictionary
- Radar detector located near 30th St and 24th Avenue in Rock Island IL
- Collected at least 50 cars per person(totaling more than 200)
## Data Organization
1. We started by merging our data into one Excel file.
2. Then uploaded the Excel file into R.
`df <- read_excel('MergedCarData.xlsx', .name_repair = 'universal')`
3. We then modified the time column so it showed as hour/minute/seconds.
`df$Time <- format(df$Time, "%H:%M:%S")`
4. We then began creating the ui for the shiny app. Writing code for the application title and the output for results displayed in the main panel.
`ui <- fluidPage(
  titlePanel("Speed Analysis"),
  mainPanel(
    h3("Results:"),
    verbatimTextOutput("min"),
    verbatimTextOutput("max"),
    verbatimTextOutput("median"),
    verbatimTextOutput("mean"),
    plotOutput("histogram")
  )
)`
5. Then We created the server for the shiny app.

## Shiny Results with Chart

- Insert charts here :)
- Remember we need to add a link somewhere
- Possibly also a link to our essay
