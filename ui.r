library(shiny)
shinyUI(pageWithSidebar(
 #Cource work application
  headerPanel ('Titanic surviving prediction'),
  sidebarPanel(
    checkboxGroupInput('id1','Methods to use',
      c('Linear model' = 'LM',
        'Regression trees' = 'RT',
        'Random forest' = 'RF',
        'Combine all 3' = 'Comb'
        )
    ),
    submitButton('Submit')
  ),
  mainPanel(
    h3 ('Accuracy for methods'),
    h4('Support vector machenes (linear kernel)'),
    verbatimTextOutput('SVM'),
    h4('Regression trees'),
    verbatimTextOutput('RT'),
    h4('Random forest'),
    verbatimTextOutput('RF'),
    h4('Combined method'),
    verbatimTextOutput('Comb')
  )
)      
)