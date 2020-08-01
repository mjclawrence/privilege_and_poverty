library(shiny)
library(tidyverse)
library(DT)
library(tidytext)
library(shinythemes)
library(googlesheets4)

sources_df <- read.csv("https://raw.githubusercontent.com/mjclawrence/privilege_and_poverty/master/addison_county_101/sources.csv")

#sources_df <- read.csv("sources.csv")
#sources_df <- mutate(sources_df, type = as.character(type))
#sources_df <- mutate(sources_df, topic = as.character(topic))


ui <- fluidPage(theme = shinytheme("spacelab"),
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
    # Create a new row for the table.
  DT::dataTableOutput("table")
))



server <- function(input, output) {
  
# Filter data based on selections
  
  output$table <- DT::renderDataTable(DT::datatable({
    data <- cbind(' ' = '&oplus;', sources_df)
    
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
    
    data
  }
  , escape = -2,
  options = list(
    columnDefs = list(
      list(visible = FALSE, targets = c(0, 2, 2)),
      list(orderable = FALSE, className = 'details-control', targets = 1)
    )
  ), 
  colnames = c("Year" = "year",
               "Author" = "author",
               "Middlebury Author" = "midd_author",
               "Title" = "title",
               "Source" = "journal",
               "Link" = "link",
               "Type" = "type",
               "Topic(s)" = "topic"),
  callback = JS("
  table.column(1).nodes().to$().css({cursor: 'pointer'});
  var format = function(d) {
    return '<div style=\"background-color:#eee; padding: .5em;\"> Description: ' +
            d[2] + '</div>';
  };
  table.on('click', 'td.details-control', function() {
    var td = $(this), row = table.row(td.closest('tr'));
    if (row.child.isShown()) {
      row.child.hide();
      td.html('&oplus;');
    } else {
      row.child(format(row.data())).show();
      td.html('&CircleMinus;');
    }
  });")))
  }

# Run the application 
shinyApp(ui = ui, server = server)