library(tidyverse)
library(forcats)
library(readxl)

# Daten laden
gifts_age <- read_csv("./data/tidytuesday-2024-02-13/gifts_age.csv")

# Sicherstellen, dass "Age" als Faktor behandelt wird und die Labels korrekt sind
age_labels <- levels(as_factor(gifts_age$Age))
gifts_age$Age <- factor(gifts_age$Age, levels = age_labels)

# Plot: Altersgruppen vs. SpendingCelebrating
ggplot(gifts_age, aes(x = Age, y = SpendingCelebrating, group = 1)) +
  geom_line(aes(color = "Data"), size = 1) +  # Linie für die Daten
  geom_smooth(aes(color = "Linear Model"), method = "lm", se = FALSE) +  # Lineares Modell hinzufügen
  labs(
    title = "Spending Behavior vs. Age",
    x = "Age Groups",
    y = "Percent Spending Money on Valentine's Day",
    color = "Legend"
  ) +
  scale_x_discrete(labels = age_labels) +  # Altersgruppen korrekt anzeigen
  theme_minimal()

# Daten für das Kuchendiagramm
spending_categories <- tibble(
  Category = c("Candy", "Flowers", "Jewelry", "Greeting Cards", "Evening Out", "Clothing", "Gift Cards"),
  Percent = c(
    mean(gifts_age$Candy, na.rm = TRUE),
    mean(gifts_age$Flowers, na.rm = TRUE),
    mean(gifts_age$Jewelry, na.rm = TRUE),
    mean(gifts_age$GreetingCards, na.rm = TRUE),
    mean(gifts_age$EveningOut, na.rm = TRUE),
    mean(gifts_age$Clothing, na.rm = TRUE),
    mean(gifts_age$GiftCards, na.rm = TRUE)
  )
)

# Kuchendiagramm
ggplot(spending_categories, aes(x = "", y = Percent, fill = Category)) +
  geom_col(width = 1, color = "white") +
  coord_polar(theta = "y") +
  labs(
    title = "Percent Spending by Category",
    fill = "Category"
  ) +
  theme_void() +
  theme(legend.position = "right")




# Erstellen einer Liste mit den Variablen, die wir untersuchen möchten
variables <- c("Candy", "GiftCards", "Flowers", "Jewelry", "GreetingCards", "EveningOut", "Clothing")

# Korrelationen zwischen "Age" und den anderen Variablen berechnen
correlations <- sapply(variables, function(var) {
  cor(as.numeric(as.factor(gifts_age$Age)), gifts_age[[var]], use = "complete.obs")
})

# Erstellen eines Dataframes für die Korrelationswerte
correlation_df <- data.frame(
  Variable = variables,
  Correlation = correlations
)

# Plot der Korrelationen
ggplot(correlation_df, aes(x = Variable, y = Correlation)) +
  geom_bar(stat = "identity", fill = "skyblue", width=0.3) +
  labs(
    title = "Korrelation zwischen Age und verschiedenen Ausgabenkategorien",
    x = "Ausgabenkategorie",
    y = "Korrelationskoeffizient"
  ) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
