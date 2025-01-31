# List of states in alphabetical order
states = [
    "alabama", "alaska", "arizona", "arkansas", "california", "colorado", "connecticut", 
    "delaware", "florida", "georgia", "hawaii", "idaho", "illinois", "indiana", "iowa", 
    "kansas", "kentucky", "louisiana", "maine", "maryland", "massachusetts", "michigan", 
    "minnesota", "mississippi", "missouri", "montana", "nebraska", "nevada", "new_hampshire", 
    "new_jersey", "new_mexico", "new_york", "north_carolina", "north_dakota", "ohio", 
    "oklahoma", "oregon", "pennsylvania", "rhode_island", "south_carolina", "south_dakota", 
    "tennessee", "texas", "utah", "vermont", "virginia", "washington", "west_virginia", 
    "wisconsin", "wyoming"
]

# Template for each R code chunk
temp = """
cor({state}_data_2$colony_lost_pct, {state}_data_2$avg_D0, method = "pearson")
cor({state}_data_2$colony_lost_pct, {state}_data_2$avg_D1, method = "pearson")
cor({state}_data_2$colony_lost_pct, {state}_data_2$avg_D2, method = "pearson")
cor({state}_data_2$colony_lost_pct, {state}_data_2$avg_D3, method = "pearson")
"""


code_template = """
<button onclick="togglePlot('{state}')">{state}</button>
<div id="{state}Plot" style="display:none;">

```{{r plot-of-data-{state}, echo = FALSE}}
  ggplot({state}_data, aes(x = as.numeric(period))) +
    geom_line(aes(y = colony_lost_pct, color = "Colony Lost (%)"), size = 1) +
    geom_point(aes(y = colony_lost_pct, color = "Colony Lost (%)"), size = 2) +
    geom_line(aes(y = avg_DSCI, color = "Average DSCI"), size = 1) +
    geom_point(aes(y = avg_DSCI, color = "Average DSCI"), size = 2) +
    scale_y_continuous(name = "Colony Lost (%)", sec.axis = sec_axis(~ ., name = "Average DSCI")) +
    scale_color_manual(values = c("Colony Lost (%)" = "blue", "Average DSCI" = "red")) +
    scale_x_continuous(
    breaks = seq_along(unique({state}_data$period)), 
    labels = unique({state}_data$period)
    ) +
    theme_minimal() +
    labs(title = "Colony Loss Percentage and Average DSCI Trends in {state_title}", x = "Period") +
    theme(axis.text.x = element_text(angle = 45, hjust = 1), panel.grid.minor = element_blank(), panel.grid.major = element_line(color = "grey90"), axis.title.y.left = element_text(color = "blue"), axis.title.y.right = element_text(color = "red"))
```

```{{r plot-of-data-D0-D4-{state}, echo=FALSE}}
  ggplot({state}_data_2, aes(x = as.numeric(period))) +
    geom_line(aes(y = colony_lost_pct, color = "Colony Lost (%)"), size = 1) +
    geom_point(aes(y = colony_lost_pct, color = "Colony Lost (%)"), size = 2) +
    geom_line(aes(y = avg_D0, color = "D0 (%)"), size = 1) +
    geom_point(aes(y = avg_D0, color = "D0 (%)"), size = 2) +
    geom_line(aes(y = avg_D1, color = "D1 (%)"), size = 1) +
    geom_point(aes(y = avg_D1, color = "D1 (%)"), size = 2) +
    geom_line(aes(y = avg_D2, color = "D2 (%)"), size = 1) +
    geom_point(aes(y = avg_D2, color = "D2 (%)"), size = 2) +
    geom_line(aes(y = avg_D3, color = "D3 (%)"), size = 1) +
    geom_point(aes(y = avg_D3, color = "D3 (%)"), size = 2) +
    scale_y_continuous(name = "Percentage") +
    scale_color_manual(values = c("Colony Lost (%)" = "blue", "D0 (%)" = "#FFCCCC", "D1 (%)" = "#FF9999", "D2 (%)" = "#FF6666", "D3 (%)" = "#FF3333", "D4 (%)" = "#CC0000")) +
    scale_x_continuous(
    breaks = seq_along(unique({state}_data_2$period)), 
    labels = unique({state}_data_2$period)
    ) +
    theme_minimal() +
    labs(title = "Drought Severity and Bee Colony Loss in {state_title} (2015-2021)", x = "Period", fill = "Drought Level",
      color = "") +
    theme_minimal() +   
    theme(
      legend.position = "bottom",
      axis.text.x = element_text(angle = 45, hjust = 1)
    )
```

</div>

"""

with open("generated_r_code.txt", "w") as file: 
  for state in states: 
    state_title = state.replace("_", " ").title() 
    state_code = temp.format(state=state, state_title=state_title)
    
    # file.write(state_code + "\n")
    print(state_code)