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
                      "img4.jpg" = "img4.jpg",
                      "img5.jpg" = "img5.jpg",
                      "img6.jpg" = "img6.jpg",
                      "img7.jpg" = "img7.jpg",
                      "img8.jpg" = "img8.jpg",
                      "img9.jpg" = "img9.jpg",
                      "img1.jpeg" = "img1.jpeg")
    
    tags$img(src = img_src, style = "width:100%;")
  })
  
  # Provide a description for the selected image
  output$imageDescription <- renderText({
    switch(input$imageSelect,
           "img4.jpg" = "This tropical paradise truly distinguishes itself with its stunning white sand beaches, embraced by a mesmerizing spectrum of deep blue and turquoise waters. You'll encounter some of the most exquisite white sand beaches globally, making beach hopping an unparalleled experience.",
           "img5.jpg" = "The Bahamas boasts the Caribbean's most renowned 'swimming with pigs' encounter, an absolute must-try during your island getaway. To embark on this adventure, you'll need to board a boat heading to Big Major Cay, often referred to as Pig Island. As you approach the island, you'll witness pigs swimming towards your boat, eager to greet you. This tour is family-friendly, but couples also relish the opportunity to bond with the Bahamas' swimming pigs. Big Major Cay lies approximately 82 miles southeast of Nassau and, aside from the pigs and their caretakers at certain times, the island remains uninhabited.",
           "img6.jpg" = "Several Caribbean islands have a reputation for drawing in the wealthy and renowned, and The Bahamas ranks prominently among them. The archipelago is a top destination for affluent travelers from around the globe. Moreover, The Bahamas extends exclusive opportunities for the ultra-wealthy to acquire their very own private islands. Within The Bahamas, you can catch glimpses of oceanfront estates owned by celebrities such as Oprah Winfrey, Michael Jordan, and a host of other well-known figures.",
           "img7.jpg" = "The Bahamas stands out as a premier destination for travelers seeking immersive diving experiences, eager to witness the underwater world at its most breathtaking. There exists a plethora of diving locations catering to both snorkelers and scuba enthusiasts. These include the Exuma Cays Land and Sea Park, the mesmerizing Andros blue holes, the awe-inspiring Conception Island Wall in Long Island, the intriguing Henry Ford Wreck in the Biminis, and the numerous vibrant reefs dotting The Abacos.",
           "img8.jpg" = "Junkanoo is a true Caribbean extravaganza, celebrated with gusto in The Bahamas on both Christmas and New Year's Day every year. This festivity can be likened to the Bahamian interpretation of a carnival. If you've never had the opportunity to partake in a Caribbean carnival, anticipate a vibrant spectacle featuring an abundance of music, elaborate costumes, live bands, traditional instruments, lively parties, colorful parades, intricate floats, and an overall atmosphere brimming with exhilaration and enthusiasm.",
           "img9.jpg" = "The Bahamas boasts several intriguing forts that you can explore during your visit. One of the prominent ones is Fort Charlotte, the largest fort on New Providence Island, nestled in Nassau. This fort was constructed by Lord Dunmore in 1788-1789 and takes its name from Queen Saharia Charlotte, the wife of King George III. It features various attractions, including a drawbridge, dungeons, underground passages, an arsenal of 42 cannons, and breathtaking panoramic views.

Fort Fincastle, dating back to 1793, is another popular attraction with its name derived from British captain Lord Dunmore, who held the title Viscount Fincastle. Legend has it that Fincastle commissioned the fort to safeguard Nassau Harbor, and it also served as a strategic lookout point against pirates. Fort Fincastle is constructed from cut limestone.

Fort Montague, another well-known fort in The Bahamas, is also crafted from local limestone. Located at the eastern end of Nassau Harbor, it holds the distinction of being the oldest fort on New Providence Island. Its history can be traced back to 1725, but its current structure was established during 1741-1742 when it played a crucial role in repelling Spanish invaders during British rule. Additionally, the site has a history of use by the United States military in 1776.",
           "img1.jpeg" = "With over 700 islands to choose from in The Bahamas, deciding where to begin your exploration can be a delightful challenge. Fortunately, there's some organization amidst this vast archipelago."
           )
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

  plot_list <- list(plot1, plot2, plot3, plot4, plot5, plot6, plot7)
  
  output$selectedPlot <- renderPlot({
    # Determine which plot to display based on user selection
    selected_item <- input$plotChoice
    
    # Create a mapping from plot names to their index
    plot_map <- c("Final consumption expenditure" = 1, 
                  "Household consumption expenditure" = 2,
                  "General government final consumption expenditure" = 3,
                  "Gross capital formation" = 4,
                  "Gross fixed capital formation" = 5,
                  "Changes in inventories" = 6,
                  "Exports of goods and services" = 7)
    
    # Retrieve the corresponding plot index
    plot_index <- plot_map[[selected_item]]
    
    # Display the selected plot
    plot_list[[plot_index]]
  })
  
  source("pop.R")
  # Reactive expression to filter data based on selected year
  filtered_data <- reactive({
    subset(pop, Year.s. == as.numeric(input$selectedYear))
  })
  
  # Render the plot
  output$populationPlot <- renderPlot({
    selected_year <- as.numeric(input$selectedYear)
    filtered_pop <- subset(pop, Year.s. >= 1970 & Year.s. <= selected_year)
    
    ggplot(filtered_pop, aes(x = Year.s., y = Value)) +
      geom_line(color = "cyan4") +
      labs(title = "Population Projections for Bahamas over years",
           x = "Year", y = "Population in Thousands")
  })
  
  
  source("gni.R")
  output$gni_plot <- renderPlot({
    gni_plot
  })
  
  source("mob.R")
  output$mob <- renderPlot({
    mob
  })
  
  
  comparison_countries <- data.frame(
    Country = c("Nassau, Bahamas", "Havana, Cuba", "Kingston, Jamaica", "Port-au-Prince, Haiti", "Santo Domingo, Dominican Republic"),
    Lat = c(25.0343, 23.1136, 18.0179, 18.5944, 18.4861),
    Lon = c(-77.3963, -82.3666, -76.8099, -72.3074, -69.9312)
  )
  
  output$mapRegional <- renderLeaflet({
    leaflet(comparison_countries) %>%
      addTiles() %>%
      setView(lng = -77.5, lat = 24.0, zoom = 5) %>%
      
      # Add colored markers for each country
      addCircleMarkers(lat = 25.0343, lng = -77.3963, color = "#00ABC9", popup = "Nassau, Bahamas") %>%
      addCircleMarkers(lat = 23.1136, lng = -82.3666, color = "darkblue", popup = "Havana, Cuba") %>%
      addCircleMarkers(lat = 18.0179, lng = -76.8099, color = "darkgreen", popup = "Kingston, Jamaica") %>%
      addCircleMarkers(lat = 18.5944, lng = -72.3074, color = "darkred", popup = "Port-au-Prince, Haiti") %>%
      addCircleMarkers(lat = 18.4861, lng = -69.9312, color = "purple", popup = "Santo Domingo, Dominican Republic")
  })
  
  ## vs Haiti
  #GDP comparison plot
  source("compare_haiti.R")
  output$gdp_bh <- renderPlot({
    # Create a function to generate and return the combined GDP plot
    generateCombinedGDPPlot()
  })
  
  
  # GNI comparison plot
  output$gniPlot_bh <- renderPlot({
    gni_plot_bh
    })
  
  # Population projection comparison plot
  output$populationPlot_bh <- renderPlot({
    population_plot_bh
    })
  
  # Mortality rate comparison plot
  output$mortalityPlot_bh <- renderPlot({
    mortality_plot_bh
  })
  
  ## vs Dominica
  #GDP comparison plot
  source("compare_dominica.R")
  output$gdp_bd <- renderPlot({
    # Create a function to generate and return the combined GDP plot
    generateCombinedGDPPlot_d()
  })
  
  
  # GNI comparison plot
  output$gniPlot_bd <- renderPlot({
    gni_plot_bd
  })
  
  # Population projection comparison plot
  output$populationPlot_bd <- renderPlot({
    population_plot_bd
  })
  
  # Mortality rate comparison plot
  output$mortalityPlot_bd <- renderPlot({
    mortality_plot_bd
  })
  
  ## vs Dominica
  #GDP comparison plot
  source("compare_dominica.R")
  output$gdp_bd <- renderPlot({
    # Create a function to generate and return the combined GDP plot
    generateCombinedGDPPlot_d()
  })
  
  
  # GNI comparison plot
  output$gniPlot_bd <- renderPlot({
    gni_plot_bd
  })
  
  # Population projection comparison plot
  output$populationPlot_bd <- renderPlot({
    population_plot_bd
  })
  
  # Mortality rate comparison plot
  output$mortalityPlot_bd <- renderPlot({
    mortality_plot_bd
  })
  
  ## vs Cuba
  #GDP comparison plot
  source("compare_cuba.R")
  output$gdp_bc <- renderPlot({
    # Create a function to generate and return the combined GDP plot
    generateCombinedGDPPlot_c()
  })
  
  
  # GNI comparison plot
  output$gniPlot_bc <- renderPlot({
    gni_plot_bc
  })
  
  # Population projection comparison plot
  output$populationPlot_bc <- renderPlot({
    population_plot_bc
  })
  
  # Mortality rate comparison plot
  output$mortalityPlot_bc <- renderPlot({
    mortality_plot_bc
  })
  
  ## vs Jamaica
  #GDP comparison plot
  source("compare_jamaica.R")
  output$gdp_bj <- renderPlot({
    # Create a function to generate and return the combined GDP plot
    generateCombinedGDPPlot_j()
  })
  
  
  # GNI comparison plot
  output$gniPlot_bj <- renderPlot({
    gni_plot_bj
  })
  
  # Population projection comparison plot
  output$populationPlot_bj <- renderPlot({
    population_plot_bj
  })
  
  # Mortality rate comparison plot
  output$mortalityPlot_bj <- renderPlot({
    mortality_plot_bj
  })
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  source("country_location.R")
  # Reactive expression to track country selections
  output$countryMapsTabs <- renderUI({
    req(input$Id001) # Ensure that there is at least one selection
    
    # Start a tabset
    tabs <- lapply(input$Id001, function(country) {
      tabPanel(
        title = country,
        leafletOutput(outputId = paste0("map_", gsub(" ", "_", country)), width = "100%", height = "400px")
      )
    })
    
    do.call(tabsetPanel, tabs)
  })
  
  # Create each map based on the selection
  observe({
    for (country in input$Id001) {
      local({
        map_id <- paste0("map_", gsub(" ", "_", country))
        country_data <- country_location[country_location$Country == country, ]
        
        output[[map_id]] <- renderLeaflet({
          leaflet() %>%
            addTiles() %>%
            setView(lat = country_data$Lat, lng = country_data$Lon, zoom = 6) %>%
            addMarkers(lat = country_data$Lat, lng = country_data$Lon, popup = country)
        })
      })
    }
  })
  
  source("compare_table.R")
  # GNI Table with filters
  output$gniTable <- DT::renderDataTable({
    DT::datatable(gni_table, 
                  filter = 'top', 
                  options = list(pageLength = 15, autoWidth = TRUE), 
                  rownames = FALSE)
  })
  
  # GDP Table with filters
  output$gdpTable <- DT::renderDataTable({
    DT::datatable(gdp_table, 
                  filter = 'top', 
                  options = list(pageLength = 15, autoWidth = TRUE), 
                  rownames = FALSE)
  })
  
  # Population Table with filters
  output$popTable <- DT::renderDataTable({
    DT::datatable(pop_table, 
                  filter = 'top', 
                  options = list(pageLength = 15, autoWidth = TRUE), 
                  rownames = FALSE)
  })
  
  # Mortality Table with filters
  output$mortalityTable <- DT::renderDataTable({
    DT::datatable(mob_table, 
                  filter = 'top', 
                  options = list(pageLength = 15, autoWidth = TRUE), 
                  rownames = FALSE)
  })
  
  
  
}


  