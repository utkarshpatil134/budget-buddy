library(shiny)

shinyServer(function(input, output, session) {
  observeEvent(input$reset, {
    updateNumericInput(session, "income", value = 35000)
    updateNumericInput(session, "housing", value = 10000)
    updateNumericInput(session, "food", value = 6000)
    updateNumericInput(session, "transport", value = 2500)
    updateNumericInput(session, "bills", value = 3000)
    updateNumericInput(session, "other", value = 4000)
    updateNumericInput(session, "goal", value = 5000)
  })

  amounts <- reactive({
    vals <- c(
      Housing = input$housing,
      `Food & groceries` = input$food,
      Transport = input$transport,
      `Bills & subscriptions` = input$bills,
      `Other spending` = input$other
    )
    vals[is.na(vals) | vals < 0] <- 0
    vals
  })

  income <- reactive({
    x <- input$income
    if (is.null(x) || is.na(x) || x < 0) 0 else x
  })

  goal <- reactive({
    x <- input$goal
    if (is.null(x) || is.na(x) || x < 0) 0 else x
  })

  total_spending <- reactive(sum(amounts()))
  leftover <- reactive(income() - total_spending())

  output$leftover <- renderText({
    paste0(if (leftover() < 0) "−" else "", format(round(abs(leftover()), 2), big.mark = ",", scientific = FALSE))
  })

  output$goal_status <- renderText({
    if (goal() == 0) {
      "No goal set"
    } else {
      pct <- max(0, min(100, leftover() / goal() * 100))
      paste0(round(pct), "%")
    }
  })

  output$spent_pct <- renderText({
    if (income() <= 0) "N/A" else paste0(round(total_spending() / income() * 100), "%")
  })

  output$spending_plot <- renderPlot({
    vals <- amounts()
    vals <- vals[vals > 0]
    if (length(vals) == 0) {
      plot.new()
      text(0.5, 0.5, "Enter an expense greater than 0 to see your chart.", cex = 1.1)
    } else {
      par(mar = c(5, 10, 2, 1))
      barplot(
        vals,
        horiz = TRUE,
        las = 1,
        col = "#2A9D8F",
        border = NA,
        main = "Monthly expenses by category",
        xlab = "Amount",
        xlim = c(0, max(vals) * 1.15)
      )
    }
  })

  output$suggestion <- renderText({
    if (income() == 0) {
      "Enter a monthly income above zero to receive a useful summary."
    } else if (leftover() < 0) {
      paste0("Your listed expenses are ", format(round(abs(leftover()), 2), big.mark = ","),
             " above your income. Review the largest categories first and adjust estimates until your plan is realistic.")
    } else if (goal() > 0 && leftover() >= goal()) {
      "Your listed expenses leave enough room to meet the savings goal you entered. Check that the amounts reflect a typical month."
    } else if (goal() > 0) {
      paste0("You are ", format(round(goal() - leftover(), 2), big.mark = ","),
             " short of your savings goal based on the expenses entered. Try adjusting a flexible category or revisiting the goal.")
    } else {
      "You have money left after the listed expenses. Consider setting a savings goal so you have a target to plan toward."
    }
  })
})
