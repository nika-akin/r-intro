library(tidyverse)
library(forcats)
library(readxl)

gifts_age <- read_csv("./data/tidytuesday-2024-02-13/gifts_age.csv")
historical_spending <- read_csv("./data/tidytuesday-2024-02-13/historical_spending.csv")
gifts_gender <- read_csv("./data/tidytuesday-2024-02-13/gifts_gender.csv")

### basic plot
category_labels <- c("Candy", "Flowers", "Jewelry", "GreetingCards", "EveningOut", "Clothing", "GiftCards")
gifts_gender_long <- gifts_gender %>%
  pivot_longer(cols = -Gender, names_to = "Category", values_to = "Value")

gifts_gender_long <- gifts_gender_long %>%
  filter(!is.na(Category) & Category %in% category_labels)

ggplot(gifts_gender_long, aes(x = Category, y = Value, fill = Gender)) +
  geom_bar(stat = "identity", position = "dodge") +
  geom_text(aes(label = paste0(round(Value, 1), "%")), position = position_dodge(width = 0.9), vjust = -0.5) +
  scale_x_discrete(labels = category_labels) +
  scale_fill_manual(values = c("Men" = "#4989ff", "Women" = "#fd4848")) +
  labs(title = "Average % Spending by Gender and Category", x = "Category", y = "Average % Spending") +
  theme_minimal() +
  theme(
    panel.grid.major = element_line(color = "#c2c2c2"),
    panel.grid.minor = element_line(color = "#787878"),
    panel.grid.major.x = element_blank(),
    panel.grid.minor.x = element_blank(),
    axis.ticks.x = element_blank(),
    axis.ticks.y = element_blank(),
    axis.title.x = element_text(margin = margin(t = 10)),
    axis.title.y = element_text(margin = margin(r = 10)),
    axis.text.x = element_text(margin = margin(t = -10))
  )
