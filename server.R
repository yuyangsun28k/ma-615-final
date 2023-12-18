source("gdp.R")

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
  
  
  #### photos of Bahamas
  output$imageDisplay <- renderUI({
    # Depending on the selected image, display it
    img_src <- switch(input$imageSelect,
                      "img1.jpeg" = "img1.jpeg",
                      "img2.jpeg" = "img2.jpeg",
                      "img3.jpeg" = "img3.jpeg")
    
    tags$img(src = img_src, style = "width:100%;")
  })
  
  
  #### global location of Bahamas
  output$GlobalMap <- renderLeaflet({
    leaflet() %>%
      addTiles() %>%  # Add default OpenStreetMap map tiles
      addMarkers(lng = -77.3963, lat = 25.0343, popup = "Bahamas") %>% # Marker for Bahamas
      setView(lng = -77.3963, lat = 25.0343, zoom = 2)  # A zoom level that shows the globe
  })
  
  
  #### narrative
  output$narrative <- renderUI({
    HTML(paste0(
      "The Bahamas is a beautiful island country located in the Lucayan Archipelago of the West Indies in the North Atlantic Ocean. The Bahamas is situated north of Cuba, northwest of Hispaniola (home to the Dominican Republic and Haiti), and southeast of Florida, USA. Originally inhabited by the Arawak and Lucayan peoples, part of the Taíno group, Bahamas has more than 3000 islands, cays and islets. The capital is Nassau on the island of New Providence. The Royal Bahamas Defence Force describes The Bahamas' territory as encompassing 470,000 km2 (180,000 sq mi) of ocean space.<br><br>",
      "Capital and Largest City: Nassau (25°04′41″N 77°20′19″W)<br>",
      "Official Languages: English<br>",
      "Vernacular Language: Bahamian Creole<br>",
      "Ethnic Groups (2020): 90.6% Black, 4.7% White, 2.1% Mixed, 1.9% Other, 0.7% Unspecified<br>",
      "Religion (2020): 93.0% Christianity (75.1% Protestantism, 17.9% Other Christian), 4.5% No Religion, 1.9% Folk Religions, 0.6% Other<br>",
      "Demonym: Bahamian<br>",
      "Government: Unitary Parliamentary Constitutional Monarchy<br>",
      "- Monarch: Charles III<br>",
      "- Governor-General: Cynthia A. Pratt<br>",
      "- Prime Minister: Philip Davis<br>",
      "Legislature: Parliament (Upper House: Senate, Lower House: House of Assembly)<br>",
      "Independence from the United Kingdom: 10 July 1973<br>",
      "Area: 13,943 km2 (5,383 sq mi), 28% Water<br>",
      "Population (2022 Census): 399,314<br>",
      "GDP (PPP, 2023 Estimate): $18.146 Billion Total, $44,949 Per Capita<br>",
      "GDP (Nominal, 2023 Estimate): $13.876 Billion Total, $34,370 Per Capita<br>",
      "HDI (2019): 0.814 (Very High, 58th)<br>",
      "Currency: Bahamian Dollar (BSD), United States Dollar (USD)<br>",
      "Time Zone: UTC−5 (EST), Summer (DST) UTC−4 (EDT)"
    ))
  })

  output$selectedPlot <- renderPlot({
    # Determine which plot to display based on user selection
    selected_item <- input$plotChoice
    
    # Create a mapping from plot names to their index
    plot_map <- c("Final consumption expenditure"=1, 
                  "Household consumption expenditure"=2,
                  "General government final consumption expenditure"=3,
                  "Gross capital formation"=4,
                  "Gross fixed capital formation"=5,
                  "Changes in inventories"=6,
                  "Exports of goods and services"=7)
    
    # Retrieve the corresponding plot index
    plot_index <- plot_map[[selected_item]]
    
    # Display the selected plot
    print(plots[[plot_index]])
  })
  
  
}


  