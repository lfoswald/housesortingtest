# props to: https://medium.com/@joyplumeri/using-r-shiny-to-create-web-surveys-display-instant-feedback-and-store-data-on-google-drive-68f46eea0f8b

#load libraries1
library(shiny)
library(gargle)
library(shinydashboard)
library(shinythemes)
library(googlesheets4)
library(DT)

#get your token to access googlesheets

options(
  gargle_oauth_cache = "shiny_app_token.rds",
  gargle_oauth_email = "XXX@gmail.com"
)

# now use googlesheets with no need for explicit auth
sheets_find(n_max = 5)


#set up data sheet in google drive
hogwarts_data <- data.frame(cbind("ex1", "ex2", "ex3", "ex4", "ex5" , "ex6",
                                  "imp1", "imp2", "imp3",
                                  "sens1", "sens2", "sens3",
                                  "ag1", "ag2", "ag3", "ag4", "ag5", "ag6", "ag7", "ag8","ag9",
                                  "loy1", "loy2", "loy3",
                                  "con1", "con2","con3",
                                  "fair1", "fair2", "fair3", "fair4", "fair5", "fair6", 
                                  "m1", "m2","m3","m4","m5",
                                  "psych1", "psych2", "psych3",
                                  "rac1", "rac2", "rac3",
                                  "ma1", "ma2","ma3","ma4","ma5","ma6","ma7",
                                  "pl1", "pl2", "pl3",
                                  "nfc1", "nfc2", "nfc3", "nfc4",
                                  "lm1", "lm2", "lm3", "lm4", "lm5", "lm6", "lm7", "lm8",
                                  "exc1", "exc2" ,
                                  "timestamp")) 

hogwarts_data <- janitor::row_to_names(hogwarts_data, row_number = 1)

Data <- gs4_create("Hogwarts_Data", sheets = hogwarts_data)    


# Define UI for application 
ui <- fluidPage(
  
  # Define UI for slider demo app ----
  ui <- fluidPage( theme = shinytheme("slate"),
                   table <- "", 
                   # App title ----
                   titlePanel("Wizarding School House Sorting Test"),
                   
                   # Sidebar layout with input and output definitions
                   sidebarLayout(
                     
                     # Sidebar to demonstrate various slider options 
                     sidebarPanel(
                       
                       h5("Please state to what extent you agree with the following items. 
                          A value of 1 represents low agreement, wheareas a value of 7 represents high agreement with the item."),
                       
                       sliderInput("ex1", "I am rather reserved.",
                                   min = 1, max = 7,
                                   value = 1),
                       sliderInput("nfc2", "I like it when my life is full of tricky tasks that I have to solve.  ",
                                   min = 1, max = 7,
                                   value = 1),
                       sliderInput("nfc3", "I would prefer more complicated problems to simple problems.  ",
                                   min = 1, max = 7,
                                   value = 1),
                       sliderInput("ex4", "I find it easy to have conversations with strangers.",
                                   min = 1, max = 7,
                                   value = 1),
                       sliderInput("rac3", "It is important to me that others show me the necessary respect. ",
                                   min = 1, max = 7,
                                   value = 1),
                       sliderInput("ma4", "I would cheat if the chance of being caught is small. ",
                                   min = 1, max = 7,
                                   value = 1),
                       sliderInput("ma5", "I only help others when I have an advantage myself. ",
                                   min = 1, max = 7,
                                   value = 1),
                       sliderInput("ma6", "People are driven by personal gain only.",
                                   min = 1, max = 7,
                                   value = 1),
                       sliderInput("ma7", "When showing weakness, you make yourself vulnerable.",
                                   min = 1, max = 7,
                                   value = 1),
                       sliderInput("pl1", "I usually think carefully before I do anything. ",
                                   min = 1, max = 7,
                                   value = 1),
                       sliderInput("ex5", "I often visit friends.",
                                   min = 1, max = 7,
                                   value = 1),
                       sliderInput("ex6", "If find it easy to spark other's excitement.",
                                   min = 1, max = 7,
                                   value = 1),
                       sliderInput("imp1", "Sometimes I spontaneously do things I should not have done.",
                                   min = 1, max = 7,
                                   value = 1),
                       sliderInput("imp2", "I usually think carefully before I do something.",
                                   min = 1, max = 7,
                                   value = 1),
                       sliderInput("imp3", "I like to take risks.",
                                   min = 1, max = 7,
                                   value = 1),
                       sliderInput("sens1", "When at the ocean and the water is cold, I go in slowly instead of jumping in.",
                                   min = 1, max = 7,
                                   value = 1),
                       sliderInput("sens2", "In life, I strive for peace, stability and harmony.",
                                   min = 1, max = 7,
                                   value = 1),
                       sliderInput("sens3", "You only live once and should collect as many experiences as possible.",
                                   min = 1, max = 7,
                                   value = 1),
                       sliderInput("ag1", "If my counterpart behaves dismissively, then I assume it is because of me.",
                                   min = 1, max = 7,
                                   value = 1),
                       sliderInput("ag2", "If I have a choice, I prefer to work in a group rather than alone.",
                                   min = 1, max = 7,
                                   value = 1),
                       sliderInput("ag3", "The feelings of others are important to me.",
                                   min = 1, max = 7,
                                   value = 1),
                       sliderInput("ag4", "I deal with differences of opinion with others openly.",
                                   min = 1, max = 7,
                                   value = 1),
                       sliderInput("ag5", "When dealing with others, I tend to avoid conflicts.",
                                   min = 1, max = 7,
                                   value = 1),
                       sliderInput("rac2", "I don't think that refugees should have the same chances for a place at university as local high school graduates. ",
                                   min = 1, max = 7,
                                   value = 1),
                       sliderInput("ag6", "I tend to be the center of attention.",
                                   min = 1, max = 7,
                                   value = 1),
                       sliderInput("ag7", "I try to treat others with care.",
                                   min = 1, max = 7,
                                   value = 1),
                       sliderInput("ag8", "I have almost never disappointed other people's trust in me.",
                                   min = 1, max = 7,
                                   value = 1),
                       sliderInput("ag9", "I prefer cooperation over competition.",
                                   min = 1, max = 7,
                                   value = 1),
                       sliderInput("loy2", "Even in the event of a fight, I try to be a good friend.",
                                   min = 1, max = 7,
                                   value = 1),
                       sliderInput("loy3", "When I think about my (possibly future) working life, I would not consider changing jobs if my employer is in crisis but I am satisfied with my job.",
                                   min = 1, max = 7,
                                   value = 1),
                       sliderInput("con1", "I have my firm principles and stick to them.",
                                   min = 1, max = 7,
                                   value = 1),
                       sliderInput("con2", " I take great care to ensure that rules are followed.",
                                   min = 1, max = 7,
                                   value = 1),
                       sliderInput("con3", "I always carry out my tasks very conscientiously and precisely. ",
                                   min = 1, max = 7,
                                   value = 1),
                       sliderInput("ex2", "I would describe myself as outgoing.",
                                   min = 1, max = 7,
                                   value = 1),
                       sliderInput("fair1", "The equal rights of minorities are important to me.",
                                   min = 1, max = 7,
                                   value = 1),
                       sliderInput("fair5", "I easily trust others and believe in the good in people.",
                                   min = 1, max = 7,
                                   value = 1),
                       sliderInput("fair6", "I tend to criticize others.",
                                   min = 1, max = 7,
                                   value = 1),
                       sliderInput("loy1", "I support my friends even in tricky situations.",
                                   min = 1, max = 7,
                                   value = 1),
                       sliderInput("m1", "I enjoy leading a group. ",
                                   min = 1, max = 7,
                                   value = 1),
                       sliderInput("m2", "I like to take influential positions. ",
                                   min = 1, max = 7,
                                   value = 1),
                       sliderInput("m3", "I like to delegate tasks and responsibilities to others.",
                                   min = 1, max = 7,
                                   value = 1),
                       sliderInput("m4", "At work it is important for me that others recognize me as the boss.",
                                   min = 1, max = 7,
                                   value = 1),
                       sliderInput("m5", "I like making decisions for others. ",
                                   min = 1, max = 7,
                                   value = 1),
                       sliderInput("psych1", "I don't find it reprehensible when someone uses violence to achieve his goals. ",
                                   min = 1, max = 7,
                                   value = 1),
                       sliderInput("psych2", "I like watching films or series with violence. ",
                                   min = 1, max = 7,
                                   value = 1),
                       sliderInput("fair2", "I sometimes put my own opinion and wishes aside so that the whole group is satisfied.",
                                   min = 1, max = 7,
                                   value = 1),
                       sliderInput("ex2", "I would describe myself as outgoing.",
                                   min = 1, max = 7,
                                   value = 1),
                       sliderInput("ex3", "I enjoy being the center of attention.",
                                   min = 1, max = 7,
                                   value = 1),
                       sliderInput("fair3", "I think that refugees should not have the same chances of getting a place at university as German high school graduates.",
                                   min = 1, max = 7,
                                   value = 1),
                       sliderInput("fair4", "When I have a sense of achievement, I share it at most with my closest people.",
                                   min = 1, max = 7,
                                   value = 1),
                       sliderInput("psych3", "I wouldn't manipulate others to achieve my goal. ",
                                   min = 1, max = 7,
                                   value = 1),
                       sliderInput("rac1", "Cultural diversity is an enrichment for society. ",
                                   min = 1, max = 7,
                                   value = 1),
                       sliderInput("pl2", "I am devising a strategy to be successful. ",
                                   min = 1, max = 7,
                                   value = 1),
                       sliderInput("pl3", "Unselfishness and helpfulness do not get you anywhere in life. ",
                                   min = 1, max = 7,
                                   value = 1),
                       sliderInput("nfc1", "It is enough for me to know the answer to a problem without understanding the background. ",
                                   min = 1, max = 7,
                                   value = 1),
                       sliderInput("nfc4", "First of all, I think because I have to.",
                                   min = 1, max = 7,
                                   value = 1),
                       sliderInput("lm1", "I enjoy working on problems that are difficult for me.  ",
                                   min = 1, max = 7,
                                   value = 1),
                       sliderInput("exc1", "I don't care about what others think of me. ",
                                   min = 1, max = 7,
                                   value = 1),
                       sliderInput("lm2", "I like situations where I can see how good I am.  ",
                                   min = 1, max = 7,
                                   value = 1),
                       sliderInput("lm3", " I am attracted to problems that are difficult to solve.  ",
                                   min = 1, max = 7,
                                   value = 1),
                       sliderInput("lm4", "I am attracted to situations where I can test my skills.  ",
                                   min = 1, max = 7,
                                   value = 1),
                       sliderInput("ma1", "Status is important to me.",
                                   min = 1, max = 7,
                                   value = 1),
                       sliderInput("ma2", "I tend to want to convince others of my opinion.",
                                   min = 1, max = 7,
                                   value = 1),
                       sliderInput("ma3", "If it helps me to get a better grade, I would cheat in an exam.",
                                   min = 1, max = 7,
                                   value = 1),
                       sliderInput("lm5", "I like being faced with challenges.  ",
                                   min = 1, max = 7,
                                   value = 1),
                       sliderInput("lm6", "It is important to me that my achievements are recognized by others. ",
                                   min = 1, max = 7,
                                   value = 1),
                       sliderInput("lm7", " It is important for me to receive detailed feedback on the quality of my work. ",
                                   min = 1, max = 7,
                                   value = 1),
                       sliderInput("lm8", "I have demonstrated great competence and commitment in all areas in which I have been active.  ",
                                   min = 1, max = 7,
                                   value = 1),
                       sliderInput("exc2", "I like being different.",
                                   min = 1, max = 7,
                                   value = 1),
                       
                       actionButton("submit", "Find out my house! (click & scroll up)")
                       
                       ),
                     
                     
                     # Main panel for displaying outputs ----
                     mainPanel(
                       
                       img(src = "hogwartstrain.png", width = 750),
                       
                       # Output: Table summarizing the values entered ----
                       tableOutput("values"),
                       
                       htmlOutput("text"),
                       
                       img(src = "dininghall.png", width = 750)
                     ))
  )
  
  
  )


server <- function(input, output, session) {
  # Reactive expression to create data frame of all input values ----
  sliderValues <- reactive({
    data.frame(
      House = c("House of Lions",
               "House of Badgers",
               "House of Serpents",
               "House of Eagles"),
      Result = c(
        # Gryffindor
        round((input$ex2+input$ex3+input$ex4+input$ex5+input$ex6+(8-input$ex1)+
                 input$imp1+input$imp3+(8-input$imp2)+
                 input$sens1+input$sens3+(8-input$sens2)+
                 (8-input$pl1)+
                 input$ag6
        )/14,3),
        
        # Hufflepuff
        round((input$ag1+input$ag2+input$ag3+input$ag5+(8-input$ag6)+input$ag7+input$ag8+input$ag9+(8-input$ag4)+
                 input$loy1+input$loy2+input$loy3+
                 input$con1+input$con2+input$con3+
                 input$fair2+input$fair3+input$fair4+input$fair5+(8-input$fair1)+(8-input$fair6)+
                 (8-input$rac2)
        )/22,3),
        
        # Slytherin
        round((input$m1+input$m2+input$m4+input$m5+(8-input$m3)+
                 input$psych1+input$psych2+(8-input$psych3)+
                 input$rac2+input$rac3+(8-input$rac2)+
                 input$ma1+input$ma2+input$ma3+input$ma4+input$ma5+input$ma6+input$ma7+
                 input$pl1+input$pl2+input$pl3+
                 (8-input$fair1)
        )/22,3),
        
        # Ravenclaw
        round((input$nfc2+input$nfc3+input$nfc4+(8-input$nfc1)+
                 input$lm1+input$lm2+input$lm3+input$lm4+input$lm5+input$lm6+input$lm7+input$lm8+
                 input$exc1+input$exc2
        )/14,3)),
      
      stringsAsFactors = FALSE)
    
  })
  
  
  
  
  # Show the values in an HTML table, only after they press submit
  observeEvent(input$submit, {
    output$values <- renderTable({
      sliderValues()
    })
    
    output$text <- renderText({
      HTML('Students of wizardy that are assigned to <b>The House of Lions</b> score high on the psychological personality factors: 
           Extraversion, Impulsiveness, and Sensation Seeking. Furthermore, they often do not plan much ahead 
           and sometimes, they like to be the centre of attention. <br><br>
           
           Young wizards assigned to <b>House of Badgers</b> score high on the personality factors: Agreeableness, Conscientiousness and Loyalty.
           Furthermore, people describe them as fair, tolerant, modest and anti racist. <br><br>
           
           Wizards related to <b>House of Serpents</b> tend to have a high Power Motive, and can show signs of Psychopathy, Machiavelism and racism. 
           Despite their dreaded reputation, they really know how to plan things. <br><br>
           
           Students of wizardy assigned to <b>House of Eagles</b>, score especially high on the psychological dimensions: Need for Cognition and Achievement Motive. 
           Some of them have a tendency towards individualism and excentric. <br><br>
           
           Disclaimer: This sorting test is based on existing psychological personality trait questionnairs and was 
           developed by a group of 5 MSc students of Psychology in the course of a psychometrics course. Nevertheless,
           the items were translated from the original German versions, some were adapted and a few items
           were created solely to cover the full range of character traits identified in the novels. And for sure, I created some coding errors in this app! 
           Therefore, this is NOT a serious personality test in any way. We do not pursue any commercial interests. 
           (The fact that when all sliders are set to 1, the house (mean) scores are not 1 is no coding error because various items are reverse coded.)
           Plese enjoy it with a pinch of salt - and share it with your fellow wizards! :-)')
    })
    })
  
  
  
  #store the results
  Results <- reactive(c(
    input$ex1, input$ex2 ,input$ex3, input$ex4, input$ex5 ,input$ex6,
    input$imp1,input$imp2,input$imp3,
    input$sens1,input$sens2,input$sens3,
    input$ag1,input$ag2,input$ag3,input$ag4,input$ag5,input$ag6,input$ag7,input$ag8,input$ag9,
    input$loy1,input$loy2,input$loy3,
    input$con1,input$con2,input$con3,
    input$fair1,input$fair2,input$fair3,input$fair4,input$fair5,input$fair6, 
    input$m1,input$m2,input$m3,input$m4,input$m5,
    input$psych1,input$psych2,input$psych3,
    input$rac1,input$rac2,input$rac3,
    input$ma1,input$ma2,input$ma3,input$ma4,input$ma5,input$ma6,input$ma7,
    input$pl1,input$pl2,input$pl3,
    input$nfc1,input$nfc2,input$nfc3,input$nfc4,
    input$lm1,input$lm2,input$lm3,input$lm4,input$lm5,input$lm6,input$lm7,input$lm8,
    input$exc1,input$exc2 , 
    Sys.time()
  ))
  
  #This will add the new row at the bottom of the dataset in Google Sheets.
  observeEvent(input$submit, {                                                                 
    Sheet  <- gs4_get('https://docs.google.com/spreadsheets/d/XXXXXXXXXXXXXXX')                                                                   
    sheet_append(Sheet, data = as.data.frame(t(Results())))                                                               
  }
  )
    }


shinyApp(ui = ui, server = server)
