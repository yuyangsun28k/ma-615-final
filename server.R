# Assuming you have similar CSV files for the Bahamas
bahamasCities <- read.csv(file = "gdp.csv")  # File containing city data for the Bahamas
bahamasIslands <- read.csv(file = "total_population_thousands.csv")  # File containing island data for the Bahamas

# Coordinates for a central location in the Bahamas, e.g., Nassau
nassauCoords <- list(lat = 25.0343, lng = -77.3963)

# Define server logic
server <- function(input, output, session) {
  # Define the coordinates for eight major cities in the Bahamas
  bahamas_cities <- data.frame(
    City = c("Nassau", "Freeport", "Lucaya", "West End", "Cooper's Town", "Marsh Harbour", "George Town", "Bimini"),
    Lat = c(25.0343, 26.5333, 26.5315, 26.6884, 26.2044, 26.5412, 23.5167, 25.7333),
    Lon = c(-77.3963, -78.6947, -78.6911, -78.9786, -77.3986, -77.0636, -75.7667, -79.2833)
  )
  
  # Initialize the map without markers
  output$mymap <- renderLeaflet({
    leaflet() %>%
      addTiles() %>%  # Add the base map tiles
      setView(lng = -77.5, lat = 24.0, zoom = 7)  # Set the initial view
  })
  
  # Track whether markers are currently displayed
  markers_displayed <- reactiveVal(FALSE)
  
  # Define an observer to add or remove markers when the button is clicked
  observeEvent(input$recalc, {
    if (markers_displayed()) {
      leafletProxy("mymap") %>%
        clearMarkers()
      markers_displayed(FALSE)
    } else {
      leafletProxy("mymap") %>%
        addMarkers(data = bahamas_cities, lat = ~Lat, lng = ~Lon, label = ~City, popup = ~City)
      markers_displayed(TRUE)
    }
  })
  
  
  
  output$imageDisplay <- renderUI({
    # Depending on the selected image, display it
    img_src <- switch(input$imageSelect,
                      "img1.jpeg" = "img1.jpeg",
                      "img2.jpeg" = "img2.jpeg",
                      "img3.jpeg" = "img3.jpeg")
    
    tags$img(src = img_src, style = "width:100%;")
  })
  
}


  