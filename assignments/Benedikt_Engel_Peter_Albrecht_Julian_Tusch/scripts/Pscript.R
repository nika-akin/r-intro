library(tidyverse)
library(forcats)
library(readxl)

historical_spending <- read_csv("./data/tidytuesday-2024-02-13/historical_spending.csv")
#historical_spending_labels <- levels(as_factor(historical_spending$Year))
#historical_spending$Year <- factor(historical_spending$Year, levels = historical_spending_labels)

only_categories <- historical_spending |> select(-any_of(c("PercentCelebrating", "PerPerson")))

longer <- only_categories |> pivot_longer(!Year, names_to = "Category", values_to = "Spending")
category_labels <- levels(as_factor(longer$Category))
longer$Category <- factor(longer$Category, levels = category_labels)

ggplot(longer, aes(x = Year, y = Spending, fill = Category)) +
    geom_bar(stat = "identity", position = "fill", width = 0.5) +
    labs(title = "Average % Spending by Category", x = "Category", y = "Average % Spending") +
    theme_minimal()

glimpse(longer)

ggplot(longer, aes(x = Year, y = Spending, shape = Category, color = Category)) +
    geom_point() +
    geom_smooth(method = "lm", se = FALSE) +
    labs(title = "Trend of spending by category", x = "Year", y = "Average spending in $") +
    scale_x_continuous(
    breaks = c(2010, 2012, 2014, 2016, 2018, 2020),   # Festlegung der Positionen der Labels
    labels = c("2010", "2012", "2014", "2016", "2018", "2020")  # Eigene Labels
  ) +
    theme_minimal()
