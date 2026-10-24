library(shiny)

shinyUI(fluidPage(
  titlePanel("Budget Buddy: Your Monthly Money Snapshot"),
  sidebarLayout(
    sidebarPanel(
      h4("Enter your monthly amounts"),
      p("Use your own amounts or try the example values. Amounts are in your local currency."),
      numericInput("income", "Monthly take-home income", value = 35000, min = 0, step = 500),
      numericInput("housing", "Housing / rent", value = 10000, min = 0, step = 500),
      numericInput("food", "Food and groceries", value = 6000, min = 0, step = 250),
      numericInput("transport", "Transport", value = 2500, min = 0, step = 250),
      numericInput("bills", "Bills and subscriptions", value = 3000, min = 0, step = 250),
      numericInput("other", "Other spending", value = 4000, min = 0, step = 250),
      numericInput("goal", "Monthly savings goal", value = 5000, min = 0, step = 250),
      actionButton("reset", "Reset example values"),
      hr(),
      helpText("Tip: use monthly totals and enter 0 for a category you do not have.")
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("My snapshot",
          br(),
          h3("Your monthly summary"),
          fluidRow(
            column(4, wellPanel(h4("Money left"), h2(textOutput("leftover", inline = TRUE)))),
            column(4, wellPanel(h4("Savings goal"), h2(textOutput("goal_status", inline = TRUE)))),
            column(4, wellPanel(h4("Spent of income"), h2(textOutput("spent_pct", inline = TRUE))))
          ),
          h4("Where your money goes"),
          plotOutput("spending_plot", height = "340px"),
          h4("Budget Buddy's suggestion"),
          wellPanel(textOutput("suggestion"))
        ),
        tabPanel("How to use",
          br(),
          h3("Getting started"),
          tags$ol(
            tags$li("Enter your take-home income for a typical month."),
            tags$li("Enter the amount you spend in each category. Use the same currency for every field."),
            tags$li("Set a monthly savings goal. Enter 0 if you do not have one yet."),
            tags$li("Open the My snapshot tab to see your remaining money, savings-goal progress, and spending chart."),
            tags$li("Change any value to update the results immediately. Use Reset example values to start over.")
          ),
          h3("What the results mean"),
          tags$ul(
            tags$li("Money left = monthly income minus the listed expenses."),
            tags$li("Savings goal status compares money left with the goal you entered; it is a planning estimate, not a bank balance."),
            tags$li("Spent of income shows listed expenses as a percentage of take-home income."),
            tags$li("The chart shows how the listed expenses compare with one another. Categories with a value of zero are omitted.")
          ),
          h3("A note about privacy"),
          p("This demo calculates results from the values you enter. It does not ask for account details or connect to a bank. Do not enter passwords or sensitive financial information."),
          p("Budget Buddy is an educational planning tool, not financial, tax, or investment advice.")
        )
      )
    )
  )
))
