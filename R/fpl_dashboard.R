library(shiny)
library(dplyr)
library(ggplot2)

player_data <- read.csv("../data/understat_player_data.csv")

# UI
ui <- fluidPage(
  titlePanel("Football Player Statistics Dashboard"),
  
  tabsetPanel(
    tabPanel("Goals and Assists",
             plotOutput("goalsAssistsPlot")),
    tabPanel("Expected Data",
             plotOutput("expectedDataPlot")),
    tabPanel("Expected Data 90",
             plotOutput("expectedData90Plot"))
  )
)

# Server
server <- function(input, output) {
  
  output$goalsAssistsPlot <- renderPlot({
    top_goals_assists <- player_data %>%
      mutate(goals_plus_assists = goals + assists) %>%
      arrange(desc(goals_plus_assists)) %>%
      head(20)
    
    ggplot(top_goals_assists, aes(reorder(player_name, goals_plus_assists), goals_plus_assists)) +
      geom_bar(stat="identity") +
      coord_flip() +
      labs(title="Top 20 Players by Goals + Assists", x="Player", y="Goals + Assists") +
      theme_minimal()
  })
  
  output$expectedDataPlot <- renderPlot({
    top_xg_xa <- player_data %>%
      mutate(xG_plus_xA = xG + xA) %>%
      arrange(desc(xG_plus_xA)) %>%
      head(20)
    
    ggplot(top_xg_xa, aes(reorder(player_name, xG_plus_xA), xG_plus_xA)) +
      geom_bar(stat="identity") +
      coord_flip() +
      labs(title="Top 20 Players by Expected Goals + Assists (xG + xA)", x="Player", y="xG + xA") +
      theme_minimal()
  })
  
  output$expectedData90Plot <- renderPlot({
    top_npxg90_xa90 <- player_data %>%
      arrange(desc(npxG_plus_xA90)) %>%
      head(20)
    
    ggplot(top_npxg90_xa90, aes(reorder(player_name, npxG_plus_xA90), npxG_plus_xA90)) +
      geom_bar(stat="identity") +
      coord_flip() +
      labs(title="Top 20 Players by npxG90 + xA90", x="Player", y="npxG90 + xA90") +
      theme_minimal()
  })
}

# Run the application 
shinyApp(ui = ui, server = server)