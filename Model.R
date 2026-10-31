# Load required libraries
install.packages("tidyverse")
library(tidyverse)

# 1. Load your data
setwd("C:/Users/liver/Downloads/")
df <- read.csv("group_4.txt")

# 2. View basic structure to ensure variables loaded correctly
str(df)
summary(df)
head(df)
tail(df)
dim(df)
nrow(df)
ncol(df)

# 3. Check correlations among water quality and environmental drivers
env_vars <- df %>% select(water_temp_C, DIN_mgL, SRP_ugL, DO_mgL, turbidity_NTU, flow_m3s, riparian_cover_pct)
cor_matrix <- cor(env_vars)
print(cor_matrix)


#### Step B: Build Model A (Multiple Linear Regression for Ecosystem Health)
#This model tests how environmental variables influence the continuous ecosystem health index[cite: 1].
# Fit the multiple linear regression model
health_model <- lm(ecosystem_health_index ~ water_temp_C + DIN_mgL + SRP_ugL + DO_mgL + riparian_cover_pct, data = df)

# View model summary (coefficients, p-values, R-squared)
summary(health_model)


#### Step C: Build Model B (Logistic Regression for Algal Blooms)
#This model predicts the probability of a bloom event occurring based on environmental triggers[cite: 1].

# Fit a logistic regression model for binary classification (bloom_event: 0 or 1)
bloom_model <- glm(bloom_event ~ water_temp_C + DIN_mgL + SRP_ugL + turbidity_NTU, 
                   data = df, 
                   family = binomial(link = "logit"))

# View model summary
summary(bloom_model)

# Calculate McFadden's Pseudo R-squared to check model fit
install.packages("pscl")
library(pscl)
pR2(bloom_model)

#Part 2: Visualizing the Relationships Using `ggplot2`

#To visualize how key drivers affect ecosystem health, you can create professional plots using `ggplot2`. 

#### 1. Scatter Plot with a Trend Line (Riparian Cover vs. Ecosystem Health)
#This plot shows how streams with higher riparian cover tend to have a higher ecosystem health index:
library(ggplot2)

ggplot(df, aes(x = riparian_cover_pct, y = ecosystem_health_index)) +
  geom_point(color = "steelblue", size = 3, alpha = 0.8) +
  geom_smooth(method = "lm", color = "darkgreen", se = TRUE) +
  labs(
    title = "Effect of Riparian Cover on Ecosystem Health",
    x = "Riparian Cover Percentage (%)",
    y = "Ecosystem Health Index"
  ) +
  theme_minimal()


#### 2. Faceted or Grouped Plot (Nutrients vs. Health, split by Bloom Events)
#You can also visualize how nutrient loading (`DIN_mgL`) relates to ecosystem health, highlighting whether a bloom event occurred (`bloom_event`):
ggplot(df, aes(x = DIN_mgL, y = ecosystem_health_index, color = factor(bloom_event))) +
  geom_point(size = 3) +
  labs(
    title = "Ecosystem Health vs. Dissolved Inorganic Nitrogen",
    subtitle = "Colored by Algal Bloom Event (0 = No Bloom, 1 = Bloom)",
    x = "Dissolved Inorganic Nitrogen (DIN mg/L)",
    y = "Ecosystem Health Index",
    color = "Bloom Event"
  ) +
  theme_minimal() +
  scale_color_manual(values = c("blue", "red"))


