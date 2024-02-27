#' class: "Computational Social Science and Digital Behavioral Data, University of Mannheim"
#' title: "Introduction"
#' author: "Sebastian Stier"
#' lesson: 2
#' institute: University of Mannheim & GESIS
#' date: "2023-02-14"


# Exercise 1: Gapminder explorations ----

library(gapminder)
gapminder <- gapminder # pull the gapminder data to the R environment


# Produce a data frame with the data for Germany and France

    
# How many countries do we have in the data? List them



# Arrange the data according to population size, in decreasing order



# Create a dataset with the variables country, year and lifeExp 

# Rename all variables to variable names of your choice
names(gapminder)

# Use mutate() to create a new variable where the population size is divided by 1 mil.


# group_by() and summarize()

# These two commands are mostly used in combination:
# "group_by" groups columns by a grouping variable
# "summarize" consolidates the mentioned column based on the grouping variable
# into a single row

# Calculate the mean GPD/Capita and population size by content



# Exercise 2: Data visualization in ggplot2 ----
library(ggplot2) # ggplot2 is part of the tidyverse and should already be loaded

# Initializing a plot
ggplot(gapminder, aes(x = lifeExp, y = gdpPercap))


# Create a scatter plot of lifeExp and gdpPercap

# Add a fit line (smoothed or linear fit)

# Add self-explanatory labs() and show GDP/Capita as logged x axis

# Save the plot
## hint: ?ggsave

# Create a bar chart showing the GDP/Capita of European countries in the year 2007


# Exercise 3: Gapminder and ggplot tasks ----

# 1) Calculate the (worldwide) average GDP per capita per year 
#    and plot this as a bar chart

# 2) Calculate the average life expectancy and the population size 
#    for the year 2007

# 3) Sum the total world population per year. 
#    Plot the results in a bar chart for the years 1992-2007


# Exercise 4: Explore a toy web tracking dataset ----

# Load the test browsing data
filename <- "data/toydt_browsing.rda"
download.file(url = "https://osf.io/download/wjd7g/", destfile = filename)
load(filename) #remove the helper object

# Load the test survey data
filename <- "data/toydt_survey.rda"
download.file(url = "https://osf.io/download/jyfru/", destfile = filename)
load(filename)
rm(filename) 


# First, let's get a feeling for the data: How many participants are in the data?

# What is the number of website visits per participant?
    
# How many of the visits happened on mobile and on desktop?  
    
# What is the time range of the data?

# What are the top ten visited domains in the data?
## Install the R package adaR: https://cran.r-project.org/web/packages/adaR/adaR.pdf
## Apply the relevant function from the package to extract domains from URLs

# Summarize the number of Facebook visits per person

# Merge the web tracking data with the survey data

# Plot the relation of Facebook visits and age

# Exercise 5: Analysis of news website visits ----

# Merge news domain information with the web browsing data
## Load U.S. news domain list
news_list <- read.csv("https://raw.githubusercontent.com/ercexpo/us-news-domains/main/us-news-domains-v2.0.0.csv")

# Get a sample of the data to test our methods first before running them to the full dataset
## hint: ?sample_n

# List the most visited news domains by the number of visits, in decreasing order

# Identify the visits whose URL contains "trump"
## hint: ?str_detect


