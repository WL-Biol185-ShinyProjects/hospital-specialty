library(shiny)
library(shinydashboard)
state_specialty <- read.table("specialty_by_state_data.csv", header = TRUE, sep = ',')

#Define UI for application that hosts all fluidpages
dashboardPage(
  dashboardHeader(title = "Physician Analysis"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Physician Specialty by State", tabName = "specialty", icon = icon("dashboard")),
      menuItem("Physicians per Capita", tabName = "capitaLeaflet", icon = icon("dashboard"))    
      )
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "specialty",
              # Define UI for application that draws a histogram
              fluidPage(
                
                # Application title
                titlePanel("Physician Specialty by State"),
                
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
      ),
      tabItem(tabName = "capitaLeaflet")
      )
    )
  
)
