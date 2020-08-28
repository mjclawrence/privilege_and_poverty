library(shiny)
library(tidyverse)
library(DT)
library(tidytext)
library(shinythemes)
library(googlesheets4)

gs4_deauth()
sources_df <- read_sheet("https://docs.google.com/spreadsheets/d/1MU6Jumo10KvDyGZYm2xjmORWcmwzJ0HlhiaZmWpikKQ/edit?usp=sharing")

#sources_df <- read.csv("https://raw.githubusercontent.com/mjclawrence/privilege_and_poverty/master/addison_county_101/sources.csv")
#sources_df <- read.csv("sources.csv")

sources_df <- mutate(sources_df, type = as.character(type))
sources_df <- mutate(sources_df, topic = as.character(topic))

sources_df$link <- paste0("<a href='",sources_df$link,"' target='_blank'>",sources_df$link,"</a>")

ui <- fluidPage(theme = shinytheme("spacelab"),
              
  titlePanel("Places of Privilege & Poverty - Additional Resources"),
  
  h1(" "),

  em(tags$a(href="http://datastudio.middcreate.net/places", "Click here to return to the homepage")),
  
  h4("Use this page to find articles and reports about poverty and economic inequality in and around Addison County, Vermont. Select topic names and document types to filter results. Search for keywords and click on the ⊕ in each row for a description and link to the resource, if available."),
  
  h1(" "),
  
# Create a new Row in the UI for Inputs
  fluidRow(
    column(3,
           checkboxGroupInput("topic",
                              "Topic(s):",
                              c("Poverty" = "poverty",
                                "Social Mobility" = "mobility",
                                "Health" = "health",
                                "Education" = "education",
                                "Race and Ethnicity" = "race",
                                "Sex" = "sex",
                                "Housing" = "housing",
                                "Punishment" = "punishment",
                                "Food Insecurity" = "food",
                                "Migration" = "migration"),
                              selected = "NULL")
    ),
    column(3,
           selectInput("type",
                       "Type:",
                       c("All",
                         "Academic Research",
                         "News Article",
                         "Policy Report", 
                         "Program Summary",
                         "Multimedia"),
                       selected = "All")
    ),
    column(3,
           radioButtons("midd_author_only",
                        "Middlebury Author(s) Only?",
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
    
    if (input$type=="All"){data} 
    else {data<-filter(data, type == input$type)}
    
    if (is.null(input$topic)){data}
    else {
      data <- data %>%
        unnest_tokens(word, topic, drop = FALSE) %>%
        filter(word %in% input$topic) %>%
        select(-word) %>%
        distinct()
    }
    
    if (input$midd_author_only == "Yes") {
      data <- filter(data, midd_author == "Yes")
    }
    
    data
  }
  , escape = FALSE,
  options = list(
    columnDefs = list(
      list(visible = FALSE, targets = c(0, 2, 3, 4)),
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
    return '<div style=\"background-color:#eee; padding: .5em;\"> <b>Description:</b> ' +
            d[2] + '<br> <br> <b>Link:</b> ' + d[4] + '<br> <br> <b>Keywords:</b> ' + d[3] + '</div>';
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