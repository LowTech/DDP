library(shiny)

shinyUI(pageWithSidebar(
  # Application title
  headerPanel("Developing Data Products Project: Inspecting Phoenix Data"),
  
  # Date picker
  sidebarPanel(
    h5('The Phoenix Data Project is an open source project for generating political event data--conflict (coups, wars, that kinda stuff) and cooperation (alliance activity, declarations of peace, etc.). Fun! This small app just looks at the # of recorded events per day, and the distribution of conflict and cooperation.'),
    h3('Choose date to inspect: *'),
    dateInput("date", "Date:", min = "2015-02-01", max = as.character(Sys.Date() - 1)),
    actionButton("goButton", "Submit"),
    h5('* Note: several dates have issues opening files; still in need of debugging issues; skip around until you find a working date, e.g., 7/11 or 7/19'),    h6('Check out the Phoenix Data Project at'),
    a('phoenixdata.org', href = "http://phoenixdata.org/")
  ),
  
  mainPanel(
    h3('# of Events'),
    verbatimTextOutput('numEvents'),
    h3('How Good/Bad was the world today?'),
    h4('Goldstein Scores, from -10 to 10'),
    h5('(-10 being most conflictual, 10 being most cooperative)'),
    plotOutput('goldsteinHist')
  )
))