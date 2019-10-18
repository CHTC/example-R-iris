library(readr)
library(dplyr)
library(tidyr)
library(ggplot2)

datafile <- "iris_data.csv"
data <- read_csv(datafile)

tidy_iris <- data %>%
  gather(Measurement, Value, -Species) %>%
  separate(col = Measurement, into = c("Part", "Measure"))

tidy_iris %>%
  group_by(Species, Part, Measure) %>%
  summarize(Minimum = min(Value), Median = median(Value), Maximum = max(Value)) %>%
  write_csv("summary.csv")

tidy_iris %>%
  filter(Measure == "Length") %>%
  ggplot() +
  geom_boxplot(aes(x = Species, y = Value)) + 
  facet_grid(. ~ Part) + 
    theme_minimal()
ggsave("species_comparison_boxplot.png")

tidy_iris %>%
  ggplot(aes(x = Value)) + 
  geom_histogram(binwidth = .2) + 
  facet_grid(Part ~ Measure) + 
  theme_minimal()
ggsave("measurement_histograms.png")

