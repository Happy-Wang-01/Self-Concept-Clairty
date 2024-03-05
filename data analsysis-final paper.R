install.packages("correlation")
library(correlation)
install.packages("Hmisc")
library(Hmisc)
install.packages("lme4")
library(lme4)
install.packages("haven")
library(haven)
install.packages("magrittr")
library(magrittr)
install.packages("readr")
library(readr)
install.packages("dplyr")
library(dplyr)
install.packages("knitr")
library(knitr)

library(tidyverse)
library(psych)
library(stats)
library(scales)
library(kableExtra)
SCC <- read_csv("Self-Concept Clarity and Deviance for R.csv")
View(SCC)

table(SCC$Education)
summary(SCC$Age)

#subdata of scc,swl,lms,age,age_sq
SCCcor <- SCC[, c("SWLScr", "SCCScr", "MYA%", "MMA%", "MEA%", "Age")] %>%
  drop_na()

#correlation matrix
matrix <- cor(SCCcor, method = "pearson")
print(matrix)
cor_to_p(matrix, n = 659, method = "pearson")

#table
kable(matrix,
      digits = 2,
      col.names = c("SWL", "SCC", "YA", "MA", "EA", "Age" ),
      align = c("c", "c", "c","c","c","c"),
      caption = "Correlations Matrix for Self-Concept Clarity, Subjective Well-Being, and Life Marker Scale Across Age" ) %>%
  kable_styling(bootstrap_options = c("striped", "hover"), full_width = F) %>%
  kable_classic(html_font = "Times New Rome") %>%
  row_spec(1, bold = T)

#Graph 1: SCC to SWL across three age group
SCC_SWL <- SCC[, c("SWLScr", "SCCScr","Age Group")] %>%
  drop_na()

ggplot(data = SCC_SWL, aes(x = SCC_SWL$SCCScr, y = SCC_SWL$SCCScr, color = SCC_SWL$`Age Group`)) +
  geom_smooth(method = lm) +
  geom_point() +
  scale_x_continuous(limits = , breaks = ) +
  scale_y_continuous(limits = ,breaks = ) +
  facet_wrap(~ SCC_SWL$`Age Group`, ncol = 3) +
  labs(x = "Self-Concept Clarity", 
       y = "Satisfaction with Life", 
       title = "Correlation between Self-Concept Clarity and Satisfaction with Life Across Age",
       color = "Age Groups") +
  theme_minimal()+
  theme(legend.position = "right",
        legend.title = element_text(family = "Times New Roman"),
        legend.text = element_text(family = "Times New Roman"),
        axis.title = element_text(family = "Times New Roman"),
        panel.grid.minor = element_blank(),
        axis.line = element_line())

#Graph 2: Histogram of age distributions
SCC_Age <- SCC[, c("Age")] %>%
  drop_na()
summary(SCC_Age)

ggplot(data = SCC_Age, aes(x = SCC_Age$Age)) +
  geom_histogram(fill= "skyblue") +
  scale_x_continuous(limits = c(18, 100), breaks = c(18, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90)) +
  scale_y_continuous(limits = c(0, 100),breaks = c(0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100)) +
  labs(x = "Age", 
       y = "Count", 
       title = "Age Distrubition of the Study") +
  theme_minimal()+
  theme(axis.title = element_text(family = "Times New Roman"),
        panel.grid.minor = element_blank(),
        axis.line = element_line(),
        title = element_text(family = "Times New Roman"))
  
