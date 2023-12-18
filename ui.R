library(shiny)
library(shinydashboard)
library(leaflet)
library(ggplot2)
library(readr)

source("gdp.R")

customCSS <- "
/* Custom Header Style */
.skin-blue .main-header .navbar {
  background-color: #00ABC9; /* Aquamarine, like the Bahamas flag */
}

/* Custom Sidebar Style */
.skin-blue .main-sidebar {
  background-color: #FAE042; /* Gold, like the Bahamas flag */
  color: black;
}

/* Custom color for sidebar menu items */
.skin-blue .sidebar a {
  color: black;
}

/* Custom Sidebar Style */
.skin-blue .main-sidebar {
  height: 100vh; /* Full height of the viewport */
  position: fixed; /* Fixed position */
  overflow-y: auto; /* Scrollbar for overflow content */
  top: 0;
  left: 0;
}
"


ui <- dashboardPage(
  skin = "blue",
  dashboardHeader(title = "Bahamas",
                  tags$li(class = "dropdown",
                          tags$img(src = "flag.svg", width = "50px",
                                   height = "50px",)
                  )),
  dashboardSidebar(
    sidebarMenu(
      menuItem("General Description", tabName = "general", icon = icon("info")),
      menuItem("Key Demographics", tabName = "demographics", icon = icon("users")),
      menuItem("Comparative Analysis", tabName = "comparison", icon = icon("line-chart")),
      menuItem("SWOT Analysis", tabName = "swot", icon = icon("tasks"))
    )
  ),
  dashboardBody(
    tags$head(tags$style(HTML(customCSS))),
    tabItems(
      tabItem(tabName = "general",
              tabBox(
                width = 18,
                tabPanel("Map of Bahamas",
                         fluidPage(
                           leafletOutput("mymap"),  # Render the leaflet map
                           p(),                      # Add a paragraph space
                           actionButton("recalc", "Show Cities")  # Add a button to display city markers
                         )
                ),
                tabPanel("Global Location", leafletOutput("GlobalMap")),
                tabPanel("Key Facts",
                # Flag Image
                tags$div(
                  tags$img(src = "flag.svg", height = "50px", alt = "Bahamas Flag"),
                  style = "text-align: center; padding: 20px;"
                ),
                # Photo Gallery with Descriptions
                fluidRow(
                  column(4, 
                         selectInput("imageSelect", "Image Gallery:", 
                                     choices = c("Image 1" = "img1.jpeg", 
                                                 "Image 2" = "img2.jpeg", 
                                                 "Image 3" = "img3.jpeg"))
                  ),
                  column(8, 
                         uiOutput("imageDisplay"))
              )),
              tabPanel("Narrative Description", uiOutput("narrative"))
              
              )
      ),
      tabItem(tabName = "demographics",
              # First fluid row for the Population Overview plot
              fluidRow(
                box(
                  width = 18,
                  title = "GDP Overview",
                  status = "primary",
                  solidHeader = TRUE,
                  collapsible = TRUE,
                  column(
                    width = 4, # Column for the select input
                    selectInput("plotChoice", "Select a plot:",
                                choices = c("Final consumption expenditure", 
                                            "Household consumption expenditure",
                                            "General government final consumption expenditure",
                                            "Gross capital formation",
                                            "Gross fixed capital formation",
                                            "Changes in inventories",
                                            "Exports of goods and services")
                    )
                  ),
                  column(
                    width = 8, # Column for displaying the selected plot
                    plotOutput("selectedPlot")
                  )
                )
              ),
              fluidRow(
                box(
                  width = 18, tableOutput("demographicsTable"), title = "Population Overview", status = "warning", solidHeader = TRUE, collapsible = TRUE)
      )),
      tabItem(tabName = "comparison",
              box(leafletOutput("mapRegional"), title = "Regional Map", status = "info", solidHeader = TRUE, collapsible = TRUE),
              box(plotOutput("comparisonPlot"), title = "Comparative Analysis", status = "success", solidHeader = TRUE, collapsible = TRUE),
              box(tableOutput("comparisonTable"), title = "Comparison Table", status = "danger", solidHeader = TRUE, collapsible = TRUE)
      ),
      tabItem(tabName = "swot",
              box(textOutput("swotAnalysis"), title = "SWOT Analysis", status = "primary", solidHeader = TRUE, collapsible = TRUE)
      )
    )
  )
)


