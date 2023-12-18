library(shiny)
library(shinydashboard)
library(leaflet)
library(leaflet.extras)
library(ggplot2)
library(readr)
library(shinyWidgets)

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

/* Style for main content when boxes are expanded */
.content {overflow-y: auto; /* Add scroll to main content */
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
                         selectInput("imageSelect", "Key factors with Info:", 
                                     choices = c("Pristine white sand beaches" = "img4.jpg", 
                                                 "The swimming pigs of Exuma" = "img5.jpg", 
                                                 "The playground of world’s rich & famous" = "img6.jpg",
                                                 "Scuba diving and snorkeling" = "img7.jpg",
                                                 "Junkanoo festival" = "img8.jpg",
                                                 "Pirate Forts" = "img9.jpg",
                                                 "Multiple Islands" = "img1.jpeg")),
                         textOutput("imageDescription")
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
                  collapsed = TRUE,
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
                  width = 18, tableOutput("demographicsTable1"), title = "Population Overview", status = "warning", solidHeader = TRUE, collapsible = TRUE,collapsed = TRUE,
                  sliderTextInput(inputId = "selectedYear",
                                  label = "Choose a Year:",
                                  choices = as.character(seq(1970, 2100, 1)),
                                  grid = TRUE),
                  plotOutput("populationPlot")),
      ),
      fluidRow(
        box(
          width = 18, tableOutput("demographicsTable2"), title = "GNI Overview", status = "success", solidHeader = TRUE, collapsible = TRUE,collapsed = TRUE,
          plotOutput("gni_plot")),
      ),
      fluidRow(
        box(
          width = 18, tableOutput("demographicsTable3"), title = "Mortality Overview", status = "danger", solidHeader = TRUE, collapsible = TRUE,collapsed = TRUE,
          plotOutput("mob")),
      )),
      tabItem(tabName = "comparison",
              box(
                uiOutput("countryMapsTabs"), title = "Regional Map Closer View", status = "success", solidHeader = TRUE, collapsible = TRUE,
                  awesomeCheckboxGroup(
                    inputId = "Id001",
                    label = "Select Countries:", 
                    choices = c("Bahamas", "Cuba", "Jamaica", "Haiti", "Dominican Republic"),
                    inline = TRUE,
                    status = "danger"
                  ),
              ),
              box(leafletOutput("mapRegional"), title = "Regional Map General Overview", status = "success", solidHeader = TRUE, collapsible = TRUE),
              box(tableOutput("comparisonTable1"),
                  title = "Comparison Charts with Haiti",
                  status = "danger",
                  solidHeader = TRUE,
                  collapsible = TRUE,
                  collapsed = TRUE,
                  tabsetPanel(
                    tabPanel("GDP", plotOutput("gdp_bh")),
                    tabPanel("GNI", plotOutput("gniPlot_bh")),
                    tabPanel("Population Projection", plotOutput("populationPlot_bh")),
                    tabPanel("Mortality Rate", plotOutput("mortalityPlot_bh"))
                  )),
              box(tableOutput("comparisonTable2"),
                  title = "Comparison Charts with Dominica",
                  status = "info",
                  solidHeader = TRUE,
                  collapsible = TRUE,
                  collapsed = TRUE,
                  tabsetPanel(
                    tabPanel("GDP", plotOutput("gdp_bd")),
                    tabPanel("GNI", plotOutput("gniPlot_bd")),
                    tabPanel("Population Projection", plotOutput("populationPlot_bd")),
                    tabPanel("Mortality Rate", plotOutput("mortalityPlot_bd"))
                  )),
              box(tableOutput("comparisonTable3"),
                  title = "Comparison Charts with Cuba",
                  status = "primary",
                  solidHeader = TRUE,
                  collapsible = TRUE,
                  collapsed = TRUE,
                  tabsetPanel(
                    tabPanel("GDP", plotOutput("gdp_bc")),
                    tabPanel("GNI", plotOutput("gniPlot_bc")),
                    tabPanel("Population Projection", plotOutput("populationPlot_bc")),
                    tabPanel("Mortality Rate", plotOutput("mortalityPlot_bc"))
                  ))
      ),
      tabItem(tabName = "swot",
              box(textOutput("swotAnalysis"), title = "SWOT Analysis", status = "primary", solidHeader = TRUE, collapsible = TRUE)
      )
    )
  )
)


