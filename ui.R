library(shiny)

# Define UI for application that draws a histogram
fluidPage(
  
  # Application title
  titlePanel("Physician Specialty by State Data"),
  
  # Sidebar with a input for selection of states
  sidebarLayout(
    sidebarPanel(
      selectInput("state",
                  "State:",
                  state_specialty$Location,
                  selected = NULL,
                  multiple = TRUE,
                  selectize = TRUE,
                  width = NULL,
                  size = NULL)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot")
    )
  )
)