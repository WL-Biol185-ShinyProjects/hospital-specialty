library(shiny)
state_specialty <- read.table("specialty_by_state_data.csv", header = TRUE, sep = ',')

# Define UI for application that draws a histogram
fluidPage(
  
  # Application title
  titlePanel("Physician Specialty by State Data"),
  
  # Sidebar with a input for selection of states
  sidebarLayout(
    sidebarPanel(
      selectInput( inputId = 'state',
                  label = 'Select a State',
                  state_specialty$Location,
                  selected = "United States",
                  multiple = FALSE,
                  selectize = FALSE,
                  width = NULL,
                  size = NULL)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("specialty_plot")
    )
  )
)

#define UI for application that draws a density map
fluidPage(
  
  # Application title
  titlePanel("Map of US Hospital Specialties"),
  
  # Sidebar with a input for selection of states
  sidebarLayout(
    sidebarPanel(
      selectInput( inputId = 'specialty',
                   label = 'Select a Specialty',
                   state_specialty$Psychiatry,
                   selected = "Other",
                   multiple = FALSE,
                   selectize = FALSE,
                   width = NULL,
                   size = NULL)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("specialty_map")
    )
  )
)