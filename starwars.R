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
