# Server side of the aliexpress dashboard 
# Last updated 09/04/2020
# Aurelien Callens


# Function to create usable buttons for URLs in the DT table 
createLink <- function(val) {
  paste0('<a href="',val,'"\n target="_blank" class="btn btn-primary">Lien</a>')
}




shinyServer(function(input, output) {

  ## Access the table with the googlesheet link: 
  
  dat <-  reactive({
    as.data.frame(read.csv("https://docs.google.com/spreadsheets/d/e/2PACX-1vRoVZ8ry-fDEvlRVj0vX5CJ3uGRhVEmXXv-BQqeFyYkR4qmVuTT-Hz_2QaPwUARyCwa09NwtqrbmuWK/pub?gid=0&single=true&output=csv"))[,-1]
  })
  
  ## Access the date stored in another tab: 
  date.update <- reactive({as.character(read.csv("https://docs.google.com/spreadsheets/d/e/2PACX-1vRoVZ8ry-fDEvlRVj0vX5CJ3uGRhVEmXXv-BQqeFyYkR4qmVuTT-Hz_2QaPwUARyCwa09NwtqrbmuWK/pub?gid=1245614953&single=true&output=csv")$date)})
  
  
  
  ## Information boxes for the main page : 
  
  ### Last updated
  
  output$progressD <- renderInfoBox({
    infoBox(" Mis à jour le | Last update", date.update(),
            icon = icon("calendar"), color = "purple")
  })
  
  ### Total number of lures
  
  output$progressB <- renderValueBox({
    valueBox(length(unique(dat()[["Imitation"]])), " Imitations | Imitations",
             icon = icon("bar-chart-o"), color = "purple")
  })
  
  ### Number of hard lures
  
  output$progressH <- renderValueBox({
    valueBox( table(unlist(dat()$Type))[1], "Leurres durs | Hard lures", 
              icon = icon("list"), color = "purple")
  })
  
  ### Number of soft lures
  
  output$progressS <- renderValueBox({
    valueBox(table(unlist(dat()$Type))[2], "Leurres souples | Soft lures", 
             icon = icon("list"), color = "purple")
  })
  
  
  ## Display diffent UI depending on the choice of the user (All | Hard | soft)
  
output$ui <- renderUI({
  
  switch(input$Type,
         "All" = radioButtons("Category", "Categories | Category :",
                                       choices = list("Toutes" = "All",
                                                      "Propbait" = "Propbait",
                                                      "Spinnerbait" = "Spinnerbait",
                                                      "Jerkbait"="Jerkbait",
                                                      "Spoon" = "Spoon",
                                                      "Jig"="Jig",
                                                      "Swimbait" = "Swimbait",
                                                      "Lipless" = "Lipless",
                                                      "Frog" = "Frog",
                                                      "Crankbait" = "Crankbait",
                                                      "Blade"="Blade",
                                                      "Popper"="Popper",
                                                      "Stickbait"="Stickbait",
                                                      "Worm"="Worm",
                                                      "Grub" = "Grub",
                                                      "Shad" = "Shad",
                                                      "Creature" = "Creature",
                                                      "Finesse"="Finesse"
                                       ), selected = "All" ),
         
         "hard" = radioButtons("Category", "Categories leurres durs | Hard bait category :",
                                     choices = list("Propbait" = "Propbait",
                                                    "Spinnerbait" = "Spinnerbait",
                                                    "Jerkbait"="Jerkbait",
                                                    "Spoon" = "Spoon",
                                                    "Swimbait" = "Swimbait",
                                                    "Lipless" = "Lipless",
                                                    "Blade"="Blade",
                                                    "Jig"="Jig",
                                                    "Crankbait" = "Crankbait",
                                                    "Popper"="Popper",
                                                    "Stickbait"="Stickbait"), selected = "Jerkbait" ),
         
         
         "soft" =  radioButtons("Category", "Categories leurres souples | Soft bait category :",
                                      choices = list("Worm"="Worm",
                                                     "Grub" = "Grub",
                                                     "Frog"= "Frog",
                                                     "Shad" = "Shad",
                                                     "Creature" = "Creature",
                                                     "Finesse"="Finesse"
                                                     ), selected = "Shad" ))
  })
  outputOptions(output, "ui", suspendWhenHidden = FALSE) 


  
  # Main table with filtering 
  output$table <- DT::renderDataTable(
    DT::datatable({
      data <-  as.data.frame(dat())
      
      # Filtering with if statements
      if (input$Water != "All") {
        data <- data[data$Water == input$Water,]
      }
      
      if (input$Type != "All") {
        data <- data[data$Type == input$Type,]
      }
      if (input$Category != "All") {
        data <- data[data$Category == input$Category,]
      }
      
      # Handling case where no results are returned
      if(dim(data)[1]==0){
        datar <- as.matrix(data.frame("Resultats | Result"= c("Pas de leurres correspondant a votre recherche ! :( ", "No lures corresponding to research criteria ! :(")))
        }else{
          #Using the function createlink to have URL button usable in table
          datar <- as.matrix(cbind(data[,-c(1,2,7)], Link=createLink(data$URL)))
          colnames(datar) <- c('Catégories | Category', 'Ressemble à | Imitate', 'Poids | Weight (g)', 'Taille | Length (cm)', 'Prix actuel | Current price (eur)', 'Prix le plus bas | Lowest price (eur)', 'Lien | Link')
          rownames(datar) <- NULL 
        }
      
      return(datar)
      
    }), server = T ,options = list(pageLength = 100, autoWidth = F), escape = FALSE)
  
  ## Force the table to load even if the user is on the main page of the dashboard
  ## to avoid the waiting. 
  outputOptions(output, "table", suspendWhenHidden = FALSE)  
  
})
