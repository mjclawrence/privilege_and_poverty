library(shiny)
library(tidyverse)
library(DT)
library(tidytext)
#library(shinythemes)

sources_df <- read.csv("sources.csv")

sources_df <- mutate(sources_df, type = as.character(type))
sources_df <- mutate(sources_df, topic = as.character(topic))


ui <- fluidPage(
    titlePanel("Addison County Sources"),
    
    # Create a new Row in the UI for Inputs
    fluidRow(
        column(3,
               checkboxGroupInput("topic",
                                  "Topic:",
                                  c("All",
                                    "Poverty" = "poverty",
                                    "Social Mobility" = "mobility",
                                    "Health" = "health",
                                    "Education" = "education",
                                    "Race and Ethnicity" = "race",
                                    "Sex" = "sex",
                                    "Housing" = "housing",
                                    "Punishment" = "punishment",
                                    "Food Insecurity" = "food",
                                    "Policy" = "policy",
                                    "Migration" = "migration"),
                                  selected = "All")
        ),
        column(3,
               selectInput("type",
                           "Type:",
                           c("All", 
                             "News Article" = "news", 
                             "Policy Report" = "policy", 
                             "Academic Research" = "academic"),
                           selected = "All")
        ),
        column(3,
               radioButtons("midd_author_only",
                           "Middlebury Author(s) Only:",
                           c("No", "Yes"),
                           selected = "No")
        ),
        column(3,
               radioButtons("abstract",
                           "Show Abstract:",
                           c("No", "Yes"),
                           selected = "No"))
    ),
    # Create a new row for the table.
    DT::dataTableOutput("table")
)



server <- function(input, output) {
    
    # Filter data based on selections

    output$table <- DT::renderDataTable(DT::datatable({
        data <- sources_df
        if (input$type != "All") {
            data <- data %>%
                unnest_tokens(word, type, drop = FALSE) %>%
                filter(word %in% input$type) %>%
                select(-word) %>%
                distinct()
        }
        if (input$topic != "All") {
            data <- data %>%
                unnest_tokens(word, topic, drop = FALSE) %>%
                filter(word %in% input$topic) %>%
                select(-word) %>%
                distinct()
        }
        if (input$midd_author_only == "Yes") {
            data <- filter(data, midd_author == "yes")
        }
        if (input$abstract == "No") {
            data <- select(data, -abstract)
        }
        data
    }
    , rownames = FALSE))
}


# Run the application 
shinyApp(ui = ui, server = server)