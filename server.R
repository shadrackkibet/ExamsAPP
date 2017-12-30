library(shiny)
library(shinydashboard)
library(ggplot2)
shinyServer(function(input,output,session){
  myData <- reactive({
      file_to_read <-  input$data_file
      if(is.null(file_to_read)) return()
     data <-  read.csv(file_to_read$datapath,header=TRUE,sep = ",")
     data
  })
  output$data_file <- renderTable({
    myData()
  })
  
  output$summary <- renderPrint({
    summary(myData()[,input$subject])
  })
  
  output$barchart <- renderPlot({
    ggplot(data = myData())+geom_bar(mapping=aes(myData()[,input$subject]) )
  })
  
  output$histogram <- renderPlot({
    ggplot(data = myData())+geom_histogram(mapping = aes(myData()[,input$subject]),bins = input$bins)
  })
  
  output$boxplot <- renderPlot({
    ggplot(data = myData())+geom_boxplot(mapping = aes(x="",y=myData()[,input$subject]))
  })
  
  output$scatterplot <- renderPlot({
    ggplot(data = myData())+geom_point(mapping = aes(y="",x=myData()[,input$subject]))
  })
  
  output$raw_data <- downloadHandler(
    filename = function(){
      paste("Exam","pdf",sep = ".")
    },
    content = function(file){
      write.csv(data_file,file)
    })
  
  output$plot <- downloadHandler(
    filename = function(){
      paste("plot","png",sep = ".")
    },
    content = function(file){
      png(file)
      boxplot(myData()[,input$subject])
      dev.off()
    }
  )
  })