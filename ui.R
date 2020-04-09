
library(shiny)
library(DT)
library(shinydashboard)

sidebar <- dashboardSidebar(width = 350,
                            hr(),
                            sidebarMenu(id="tabs",
                                        menuItem("Accueil | Home page", tabName="acceuil", icon=icon("fas fa-tint"), selected=TRUE),
                                        menuItem("Recherche | Lure finder",  icon = icon("fas fa-list"),
                                          menuSubItem("Leurres | Lures", tabName = "leurre", icon = icon("angle-right")),
                                          menuSubItem("Matériel |Tackle", tabName = "materiel", icon = icon("angle-right"))
                                                ),
                                        menuItem("Contactez nous | Contact us", tabName = "contact", icon=icon("fas fa-comments")),
                                        menuItem("A propos | About", tabName = "about", icon = icon("question"))
                                        )

                            )

body <- dashboardBody(
  tags$head(HTML('<link rel="icon" type="image/png" href="favicon-32x32.png" sizes="32x32" />')),

  tabItems(

    tabItem(tabName = "acceuil",
     
      br(),
      fluidRow(
        column(width = 8,
               tabBox(
                 title = h3("Quelques mots | Few words"),
                 id = "tabset1", height = "550px",
                 tabPanel("Fr", 
                          h3("Bienvenue sur le site internet qui va t'aider à faire tes achats de matériel de pêche sur aliexpress !"),
                          h3("Quel est le principe ?"),
                          br(),
                          p("Ce site rend accessible une base de données que l'on a rassemblé durant quelques semaines.
                            Elle contient les leurres aliexpress qui valent le coup ! 
                            Pour chaque leurre on a rassemblé un max d'information : sa ressemblance fortuite avec un leurre de marque, sa taille, son poids, son prix actuel et son prix le moins cher depuis la mise en ligne du site. 
                            En effet, depuis cette date (01/05/2018) on traque le prix quotidiennement pour voir si le prix à tendance à augmenter ou diminuer !"),
                          p("Vous l'avez compris : les achats au prix fort c'est fini !!!"),
                          h3("Comment utiliser cette application ?"),
                          br(),
                          p("Allez dans l'onglet recherche, selectionnez dans le menu le type et la catégorie de leurres que vous recherchez et SURPRISE : un beau tableau récapitulatif de tous les liens qui correspondent à votre recherche. Vous pouvez également affiner votre selection en cliquant sur les colonnes qui vous intéressent pour un tri en ordre alphabétique ou croissant ! "),
                          br(),
                          p("N'hésitez pas à nous contacter pour signaler des liens morts, des bugs ou pour partager vos bonnes affaires !")
                          
                          
                          
                          ),
                 tabPanel("En", h3("Welcome to a website that will help you with fishing tackle shopping on Aliexpress !"),
                          h3("How does it work ?"),
                          br(),
                          p("This website allows one to access a dataset that we have collected for weeks. This dataset is about aliexpress fishing lure that are worth your money ! For each lure, we gathered a lot of information such as fortuitous resemblance with famous brand, its length, its weight, its current price and the lowest price since the creation of this website. 
                            Indeed, since this date (01/05/2018), we are stalking the price daily to see if the price increase or decrease."),
                          p("I think you got it : paying a high price for lures is over !!!"),
                          h3("How can I use this website?"),
                          br(),
                          p("Go in the research tab, select the desired type and category and SURPRISE : a nice table of all the lures that match your criteria. You can also order your selection by alphabetical order or ascending/descending order by clicking on the columns that are interesting you."),
                          br(),
                          p("Please don't hesitate to contact us if there is any error, dead link or to share your good deals!")
                          ), width = 12
               )),

        column(width = 4,
               box(title = "Quelques chiffres | Few figures", status = "primary", height = "550px",solidHeader = TRUE,
                   infoBoxOutput("progressD", width = 12),
                   valueBoxOutput("progressB", width = 12),
                   valueBoxOutput("progressH", width = 12),
                   valueBoxOutput("progressS", width = 12), width = 12 ))

              )),
    
    tabItem(tabName = "leurre",
            sidebarLayout(
              sidebarPanel(
                
                selectInput("Water","Peche en mer ou en eau douce | Fresh or salt water fishing",
                            list("Les deux | Both" = "All",
                                 "Mer | Salt" = "salt",
                                 "Eau douce | Fresh" = "fresh")
                            ),
                
                selectInput("Type","Type de leurres | Types of lures",
                            list("Tous | Both" = "All",
                                 "Durs | Hard" = "hard",
                                 "Souples | Soft" = "soft")
                            ),
                
                uiOutput("ui")
                          ),
              
              mainPanel(
                DT::dataTableOutput("table")
                        )
                        )
            ),
    
    tabItem(tabName = "materiel",
            
            box( width = NULL, status = "primary", solidHeader = TRUE, title="En construction | Work in progress")
            
            ),
    
    tabItem(tabName = "contact",
            
            tabBox( width = NULL, title="Contactez nous | Contact us",
                    tabPanel("Fr", 
                            h3("Pour signaler une erreur ou un bug : "),
                            h5(HTML(paste0('Cliquez sur ce bouton :',a(actionButton(inputId = "email1", label = "", 
                                                                        icon = icon("envelope", lib = "font-awesome")),
                                                           href="mailto:lure-finder@outlook.fr?subject=Error"),'et décrivez nous le bug/erreur'))),
                            
                            h3("Pour signaler un lien mort ou une rupture de stock : "),
                            h5(HTML(paste0('Cliquez sur ce bouton :',a(actionButton(inputId = "email1", label = "", 
                                                                                    icon = icon("envelope", lib = "font-awesome")),
                                                                       href="mailto:lure-finder@outlook.fr?subject=Deadlink"),'et copiez les liens morts dans le corps du mail.'))),
                            h3("Pour partager vos bonnes affaires : "),
                            h5(HTML(paste0('Cliquez sur ce bouton :',a(actionButton(inputId = "email1", label = "", 
                                                                                    icon = icon("envelope", lib = "font-awesome")),
                                                                       href="mailto:lure-finder@outlook.fr?subject=Newlink"),'et copiez les liens des bonnes affaires non présentes sur ce site dans le corps du mail !'))),
                            h3("Pour autre chose : "),
                            h5(HTML(paste0('Cliquez sur ce bouton :',a(actionButton(inputId = "email1", label = "", 
                                                                                    icon = icon("envelope", lib = "font-awesome")),
                                                                       href="mailto:lure-finder@outlook.fr?subject=Other"))))
                            ),
                    tabPanel("En",
                             h3("To signal a bug or an error : "),
                             h5(HTML(paste0('Click on this button :',a(actionButton(inputId = "email1", label = "", 
                                                                                     icon = icon("envelope", lib = "font-awesome")),
                                                                        href="mailto:lure-finder@outlook.fr?subject=Error"),'and describe the error.'))),
                             h3("To signal a dead link or out of stock : "),
                             h5(HTML(paste0('Click on this button  :',a(actionButton(inputId = "email1", label = "", 
                                                                                     icon = icon("envelope", lib = "font-awesome")),
                                                                        href="mailto:lure-finder@outlook.fr?subject=Deadlink"),'and paste the dead links.'))),
                             h3("To share your good deals with others"),
                             h5(HTML(paste0('Click on this button  :',a(actionButton(inputId = "email1", label = "", 
                                                                                     icon = icon("envelope", lib = "font-awesome")),
                                                                        href="mailto:lure-finder@outlook.fr?subject=Newlink"),'and paste the link of the good deals not present on this website !'))),
                             h3("Other :"),
                             h5(HTML(paste0('Click on this button  :',a(actionButton(inputId = "email1", label = "", 
                                                                                     icon = icon("envelope", lib = "font-awesome")),
                                                                        href="mailto:lure-finder@outlook.fr?subject=Other"))))
                    )
          
            
            )),
    
    tabItem(tabName = "about",
            
            tabBox( width = NULL, title="A propos | About",
                    tabPanel("Fr" ,
                            fluidRow(column(width=12,
                            h3("Présentation"),
                            p("Bonjour,"),
                            p("Nous sommes Tom et Aurélien, deux étudiants passionnés par la pêche !"),
                            p("Il y a moins de 6 mois, nous découvrions les joies du shopping sur Aliexpress : des leurres et du petit matériel de qualité a des prix défiants toute concurrence. C'est super vous allez me dire !
                              Oui, mais nous découvrions aussi l'enfer du shopping sur Aliexpress : des milliers de références avec des prix différents pour le même objet, des leurres qui nagent pas toujours bien et des heures et des heures de recherches sur le net pour trouver les bonnes affaires..."),
                            p(" Le but de ce site internet est de faciliter la recherche des meilleurs leurres disponibles en seulement quelques clics.
 N’hésitez pas à nous faire part de vos impressions (rubrique « Contactez-nous ») afin d’apporter des améliorations et ce pour votre plus grand confort :)"),
                            p("A bientôt !"),
                            h3("Nos sources"),
                            p("Voici les sources qui nous ont servis à faire notre base de données, on vous conseille vivement d'aller y faire un tour pour plus de renseignements et de tests sur les leurres aliexpress!"),
                            h4("Les chaines Youtube :"),
                            tags$ul(
                                tags$li(a("Capitaine Brochet",     href="https://www.youtube.com/channel/UCNLp0ytHTzmJOavNwLyxuzg")
                                ),
                                tags$li(a("Carna fishing family",     href="https://www.youtube.com/channel/UCJPRiEprB-IUsMF1dyEHqyg")),
                                
                                tags$li(a("HobbyFish",     href="https://www.youtube.com/channel/UCuNuBvchuH6-FN7YI8ZetoQ/videos")),
                                
                                tags$li(a("Jules Don",     href="https://www.youtube.com/channel/UCDPsPrHelBXjoUQky9mfMuA")),
                                
                                tags$li(a("Pêcheur du Sud",     href="https://www.youtube.com/channel/UCJQLSfZlM1Uf9YIPnKRkhmg")),
                                
                                tags$li(a("faz la peche ",     href="https://www.youtube.com/channel/UCg3B-aobYDIlUmW9xoeSFQg")),
                                
                                tags$li(a("Antoine viril",     href="https://www.youtube.com/channel/UCIyC4UAPwVaV4bNws_N57wA"))
                                
                                
                              ),
                            h4("Forums :"),
                            tags$ul(
                            tags$li(a("Les leurres chinois sur achigan.net",     href="http://www.achigan.net/msgforum.php?id_sujet=15294&debut=0"))
                            )
                              
                            )
                              
                          
                            )
        
                             
                    ),
                    tabPanel("En",
                             fluidRow(column(width=12,
                                             h3("Presentation"),
                                             p("Hello,"),
                                             p("We are Tom and Aurélien, two students passionate about fishing !"),
                                             p("Less than 6 months ago, we discored the advantages of Aliexpress shopping : high quality lures and fishing tackles with unbeatable prices. You will say 'It's awesome' !
                                               Yes, but we also discovered the disadvantages of Aliexpress shopping : thousands of lures with different prices for the same object, lures that aren't really good and finally hours and hours of research for a good deal..."),
                                             p(" That's why we decided to create this tool and share it with our angler friends. The aim of this website is to make the search for the best lures available far easier.
                                               Don't hesitate to share your feeling with us (tab « Contact us ») in order to improve our website for your confort :)"),
                                             p("See you soon !"),
                                             h3("Our sources"),
                                             p("You can find the sources which help us for making the dataset, you should definitively check them for more aliexpress lure reviews ! (French sources)"),
                                             h4("Youtube chanel :"),
                                             tags$ul(
                                               tags$li(a("Capitaine Brochet",     href="https://www.youtube.com/channel/UCNLp0ytHTzmJOavNwLyxuzg")
                                               ),
                                               tags$li(a("Carna fishing family",     href="https://www.youtube.com/channel/UCJPRiEprB-IUsMF1dyEHqyg")),
                                               
                                               tags$li(a("HobbyFish",     href="https://www.youtube.com/channel/UCuNuBvchuH6-FN7YI8ZetoQ/videos")),
                                               
                                               tags$li(a("Jules Don",     href="https://www.youtube.com/channel/UCDPsPrHelBXjoUQky9mfMuA")),
                                               
                                               tags$li(a("Pêcheur du Sud",     href="https://www.youtube.com/channel/UCJQLSfZlM1Uf9YIPnKRkhmg")),
                                               
                                               tags$li(a("faz la peche ",     href="https://www.youtube.com/channel/UCg3B-aobYDIlUmW9xoeSFQg")),
                                               
                                               tags$li(a("Antoine viril",     href="https://www.youtube.com/channel/UCIyC4UAPwVaV4bNws_N57wA"))
                                               
                                               
                                             ),
                                             h4("Forums :"),
                                             tags$ul(
                                               tags$li(a("Chinese lures on achigan.net",     href="http://www.achigan.net/msgforum.php?id_sujet=15294&debut=0"))
                                             )
                                             
                                             ))
                             
                    )
                    
                    
            )
            )
    
        )
      )

dashboardPage(
  
  dashboardHeader(title = "Recherche de leurres Aliexpress",titleWidth = 350),
  
  sidebar,
  
  body
)





