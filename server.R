library(shiny)

colNames = c("EventID", "Date", "Year", "Month", "Day", "SourceActorFull", 
             "SourceActorEntity", "SourceActorRole", "SourceActorAttribute", 
             "TargetActorFull", "TargetActorEntity", "TargetActorRole", 
             "TargetActorAttribute", "EventCode", "EventRootCode", "PentaClass", 
             "GoldsteinScore", "Issues", "Lat", "Lon", "LocationName", "StateName", 
             "CountryCode", "SentenceID", "URLs", "NewsSources")

shinyServer(
  function(input, output) {
    output$numEvents <- renderText({
      if (input$goButton == 0)
        return()
      
      isolate({
        # Download the data for the specified day
        fileName <- paste('events.full.', format(as.Date(input$date), "%Y%m%d"), '.txt', sep = "")
        zipName <- paste(fileName, '.zip', sep = "")
        webName <- paste('http://s3.amazonaws.com/openeventdata/current/', zipName, sep = "")
        download.file(webName, zipName)
        unzip(zipName)
        
        data <- read.table(fileName, sep = "\t", col.names = colNames, comment.char = "", as.is = TRUE)
        
        # Return the event count
        nrow(data)
      })
    })
    
    output$goldsteinHist <- renderPlot({
      if (input$goButton == 0)
        return()
      
      isolate({
        # Download the data for the specified day
        fileName <- paste('events.full.', format(as.Date(input$date), "%Y%m%d"), '.txt', sep = "")
        
        data <- read.table(fileName, sep = "\t", col.names = colNames, comment.char = "", as.is = TRUE)
        
        # Return the event count
        hist(data$GoldsteinScore)
      })
    })
})