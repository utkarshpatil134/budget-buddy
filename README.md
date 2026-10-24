# Budget Buddy — Shiny app and reproducible pitch

Budget Buddy is a simple monthly budget planner built with R Shiny. Users enter take-home income, typical spending categories, and a savings goal. The app calculates leftover money, spending as a share of income, savings-goal progress, and a reactive expense chart.

## Files

- `ui.R` — interface, input widgets, results area, and built-in beginner documentation.
- `server.R` — reactive calculations, chart, savings-goal feedback, and reset behavior.
- `Budget_Buddy_Pitch.Rmd` — five-slide RStudio Presenter / `ioslides` pitch. The example R chunk is evaluated when knitted.

## Run locally

1. Install R and RStudio.
2. In R, install Shiny if needed: `install.packages("shiny")`.
3. Open this project folder as the working directory in RStudio.
4. Run `shiny::runApp()` in the Console. The app opens in a browser.
5. Open `Budget_Buddy_Pitch.Rmd` and click **Knit** to make the five-slide HTML presentation.

## How a novice uses the app

Enter monthly take-home income, then enter typical monthly costs in each category. Keep the same currency across all fields. Set a savings goal, then view **My snapshot** for the remaining amount, savings-goal status, expense chart, and suggestion. Change a number to update results immediately. The **How to use** tab explains the calculations, and **Reset example values** restores the sample values.

## Publish the app

Create an account on shinyapps.io and follow its current deployment instructions from RStudio. Install `rsconnect` if needed, configure your account token as directed by shinyapps.io, open this folder in RStudio, and deploy the application. After deployment, open the public app URL and test the inputs and chart.

## Share code on GitHub

Create a GitHub repository, then commit and push `ui.R`, `server.R`, `Budget_Buddy_Pitch.Rmd`, and this README. Do not commit account tokens or passwords.

## Publish the pitch

Open `Budget_Buddy_Pitch.Rmd` in RStudio and click **Knit**. Confirm that the output has exactly five slides and that the R example table displays. Use the presentation window's **Publish** button to publish to RPubs, or push the HTML and its assets to GitHub Pages.

Replace `Your Name` in the pitch YAML with your name before publishing. This project was prepared on October 24, 2026; update the date if your course requires the actual date you complete or submit it.
