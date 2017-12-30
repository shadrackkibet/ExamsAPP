library(shiny)
library(shinydashboard)
shinyUI(
  dashboardPage( title = "examsapp",skin = "blue",
  dashboardHeader(title = "Exams processing app:",titleWidth = 300),
  dashboardSidebar(width = 300,
    sidebarMenu(
      fileInput("data_file","Upload the file:"),
      selectInput("subject","Select Subject:",choices = c("Language"="LANGUAGE","Composition"="COMPOSITION","Kiswahili"="LUGHA","Insha"="INSHA","Mathematics"="MATHEMATICS","Science"="SCIENCE","Social Studies"="S.S","Religious Education"="C.R.E"),selected = "LANGUAGE" )
      )),
    dashboardBody(
      tabsetPanel(
        type="tab",
        tabPanel("Raw Data",downloadButton("raw_data","Download Raw Data"),
               tableOutput("data_file")
                 ),
        tabPanel("Tabulated Data",downloadButton("tabulated_data","Download Tabulated Data")
                 
                 ),
        tabPanel("Summaries",
                 verbatimTextOutput("summary")
                 ),
        tabPanel("Plots",
                 fluidRow(
                   tabBox(
                     tabPanel("Barchart", plotOutput("barchart"),icon = icon("bar-chart")),
                     tabPanel("Histogram", plotOutput("histogram"),icon = icon("bar-chart"),
                              sliderInput("bins","Number of breaks:",1,100,50)),
                     tabPanel("Boxplot", plotOutput("boxplot")),
                     tabPanel("Scatter plot", plotOutput("scatterplot")),
                     downloadButton("plot","Download Plot")
                   )
                   )
                 )
                 )
                )
      )
    )
  
