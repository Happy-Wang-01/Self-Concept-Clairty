library(tidyverse)

## Create your goal tibble to replicate

# Run this line to see what your end product should look like
sw.wrangled.goal <- read_csv("sw-wrangled.csv") %>% 
  mutate(across(c(hair, gender, species, homeworld), factor)) # this is a quick-and-dirty fix to account for odd importing behavior

# View in console
sw.wrangled.goal 

starwars

df_sw.wranged

# Examine the structure of the df and take note of data types
# Look closely at factors (you may need another function to do so) to see their levels
str(sw.wrangled.goal)
str(sw.wranged)
str(starwars)

df <- starwars

data("starwars")

## Use the built-in starwars dataset to replicate the tibble above in a tbl called sw.wrangled
# If you get stuck, use comments to "hold space" for where you know code needs to go to achieve a goal you're not sure how to execute
df_sw.wranged <- starwars %>% 
#separate names into first_name, and last_name
  separate_wider_delim(name, " ", names = c("first_name", "last_name"), too_few = "align_start", too_many = "merge")%>%
  #create initials, but not sure if this function will extract both first and last names
  mutate(initials = paste0(substr(first_name, 1, 1), substr(last_name, 1, 1)))%>%
#arrange based on last name alphabetical order
  arrange(last_name)%>%
#create height in inch and round up to 1 decimal point
  mutate(height_in = height * 0.3937)%>%
#change the height into height_cm and numerical value
  mutate(height_cm = as.numeric(height))%>%
#replace the NA in hair_color as none and rename the variable
  replace_na(list(hair_color="none"))%>%
  rename(hair = hair_color)%>%
#change the variable "masculine" into "m" and "feminine" into "f"
  mutate(gender = paste0(substr(gender, 1,1)))%>%
#create the brown_hair column
  mutate(brown_hair = (hair == "brown"))%>%
#changing the case for species
  mutate(species = toupper(species))%>%
#select the target variables
  select(first_name, last_name, initials, height_in, height_cm, mass, hair, gender, species, homeworld, brown_hair)%>%
#reorder the target variables
  relocate(first_name, last_name, initials, height_in, height_cm, mass, hair, gender, species, homeworld, brown_hair)

print(df_sw.wranged)  

#I don't know how to see the whole display of the starwar dataset, therefore cannot know if there is anything to change in the species and homeworld column
#Also, I am not sure how to see if what I did work or not, like where can I see the display. 
#Because if I print(sw_wrangled) the dataset Professor Dowling shared would popup
#instead of the changes that I made

## Check that your sw.wrangled df is identical to the goal df
# Use any returned information about mismatches to adjust your code as needed
all.equal(sw.wrangled.goal, sw.wrangled.goal)

#Assignment 11 part 1
#Plot 1: frequency for height_cm
ggplot(sw.wrangled.goal) +
  geom_histogram(aes(x = height_cm), binwidth = 10) +
  scale_y_continuous(breaks = seq(0,20, by = 5))
#Plot 2: frequency for hair
freq_table <- table(sw.wrangled.goal$hair)
freq_table
freq_hair_df <- data.frame(hair = names(freq_table), freq = as.numeric(freq_table))
freq_hair_df <- freq_hair_df[order(freq_hair_df$freq, decreasing = TRUE), ]
sw.wrangled.goal$hair <- factor(sw.wrangled.goal$hair, levels = freq_hair_df$hair)
ggplot(sw.wrangled.goal) +
  geom_bar(aes(x = hair)) +
  labs(x = "sorted_hair")
#Plot 3: scatter plot for mass and height_in
ggplot(data = sw.wrangled.goal, aes(x = height_in, y = mass)) +
  geom_point(shape = 24, colour = "black", fill = "black") +
  scale_y_continuous(limits = c(0, 160), breaks = c(seq(0,160, by = 40)) ) +
  scale_x_continuous(breaks = c(seq(0,90, by = 20)))


##Assignment 12 Part 1
#Plot 1: Hair color and Mass Box plot
ggplot(sw.wrangled.goal) +
  geom_boxplot(aes(x = hair, y = mass, fill = hair)) +
  scale_y_continuous(limits = c(0, 160), breaks = c(seq(0, 160, by = 40))) +
  geom_point(data = sw.wrangled.goal, aes(x = hair, y = mass)) +
  labs (x = "Hair color(s)", y = "Mass(kg)", fill = "Colorful hair")
#Plot 2: Compare correlations between mass, height, and hair
ggplot(sw.wrangled.goal, aes(x = mass, y = height_in, color = brown_hair)) +
  geom_smooth(method = lm) +
  geom_point()+
  scale_x_continuous(limits = c(-200, 200), breaks = c(seq(-200, 200, by = 100))) +
  scale_y_continuous(limits = c(-4, 200), breaks = c(-4, 20, 23, 60, 80, 90, 100, 110, 120), 
                     labels = c(-4, 20, 23, " ", 80, " ", 100, " ", " ")) +
  facet_wrap(~ factor(brown_hair, levels = c("TRUE", "FALSE")), ncol = 2, labeller = labeller(brown_hair = c("TRUE" = "Has brown hair", "FALSE" = "No brown hair" ))) +
  theme_minimal()+
  labs(x = "mass", y = "height_in", color = "brown hair", title = "Mass vs. height by brown-hair-havingness")
#Plot 3: species first letter frequency plot
sw_first_letter <- sw.wrangled.goal %>%
  mutate(first_letter = substr(species, 1, 1)) %>%
  drop_na() %>%
  group_by(first_letter, gender) %>%
  summarise(count = n()) %>%
  arrange(first_letter) %>%
  ungroup()

ggplot(sw_first_letter, aes(x = count, y = first_letter, fill = gender)) +
  geom_bar(stat = "identity", position = "stack") +
  scale_x_continuous(limits = c(0, 30), breaks = c(seq(0, 30, by = 10))) +
  labs(x = "count", y = "species_first_letter", caption = "A clear male human bias") +
  scale_fill_manual(values = c("m" = "skyblue", "f" = "pink")) +
  theme_minimal() +
  theme(legend.position = "right") 
#I don't know how to revise the order of the graph

## Assignment 13 Part 1
#Plot 1: Hight and Weight Across Gender correlation plot
install.packages("ggplot2")
library(ggplot2)
install.packages("ggsci")
library(ggsci)
ggplot(sw.wrangled.goal, aes(x = height_cm, y = mass, color = gender)) +
  geom_smooth(method = lm) +
  geom_point() +
  scale_x_continuous(limits = c(60, 270), breaks = c(seq(60,270, by = 30))) +
  facet_wrap(~ factor(gender, levels = c("f", "m", NA)), 
             ncol = 3, 
             scales = "free_y", 
             labeller =labeller(gender = c(f = "Female", m = "Male", "NA" = "Other")) ) + #I have no idea why the facet lable did not change
  scale_color_manual(values = c(f = "maroon", m = "#767575", "NA" = "#ffa21a")) + #I don't know how to change the color of the NA
  labs(x = "Height(cm)", 
       y = "Mass(kg)", 
       title = "Height and weight accross gender presentation", 
       subtitle = "A cautionary tale in midleading ''free'' axis scales & bad design choice",
       caption = "Color hint: use the ggsci package!",
       color = "Gender Presentation") +
  theme(strip.background = element_rect(fill = "darkgreen", color = "black"),
        strip.text = element_text(hjust = 0, color = "white"),
        axis.title.x = element_text(angle = 45, hjust = 1),
        panel.background = element_rect(fill = "#FFEFEC"),
        panel.grid.major.x = element_line(colour = "white", linetype = 5),
        panel.grid.minor.x = element_blank(),
        panel.grid.major.y = element_line(colour = "lightgrey", linetype = 4),
        panel.grid.minor.y = element_blank(),
        text = element_text(family = "Helvetica"),
        legend.position = "bottom",
        legend.title = element_text(family = "Brush Script MT"),
        legend.key = element_rect(fill = "lavender"), 
        legend.box.background = element_rect(fill = "lavender", color = "black", size = 1),
        plot.caption = element_text(colour = "red", hjust = 0, angle = 180)
        )
# I don't know how to change the color fill of the legend box
# I still haven't figured out how to change the facet/panel names
# I wonder do I need to modify the NA into something else to make it show up in the legend key


