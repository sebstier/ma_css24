#' class: "Computational Social Science and Digital Behavioral Data, University of Mannheim"
#' title: "Web data and designed digital data"
#' author: "Sebastian Stier"
#' lesson: 3
#' institute: University of Mannheim & GESIS
#' date: "2024-03-13"


# Exercise 1: Gapminder and ggplot tasks ----

# 1) Calculate the (worldwide) average GDP per capita per year 
#    and plot this as a bar chart

# 2) Calculate the average life expectancy and the population size 
#    for the year 2007

# 3) Sum the total world population per year. 
#    Plot the results in a bar chart for the years 1992-2007


# Exercise 2: Explore a toy web tracking dataset ----

# Load the test browsing data
filename <- "data/toy_browsing.rda"
download.file(url = "https://osf.io/download/52pqe/", destfile = filename)
load(filename)

# Load the test survey data
filename <- "data/toy_survey.rda"
download.file(url = "https://osf.io/download/jyfru/", destfile = filename)
load(filename)
rm(filename) 


# First, let's get a feeling for the data: How many participants are in the browsing data?

# Aggregate the number of website visits per participant
    
# How many of the visits happened on mobile and on desktop?  
    
# What is the time range of the data?

# What are the top ten visited domains in the data?
## Install the R package adaR: https://cran.r-project.org/web/packages/adaR/adaR.pdf
## Apply the relevant function from the package to extract domains from URLs

# Summarize the number of Facebook visits per person

# Merge the web tracking data with the survey data

# Plot the relation of Facebook visits and age


# Exercise 3: Analysis of news website visits ----

# Merge the news domain information with the web browsing data
## Load U.S. news domain list
news_list <- read.csv("https://raw.githubusercontent.com/ercexpo/us-news-domains/main/us-news-domains-v2.0.0.csv")

# Get a sample of the data to test our methods first before running them on the full dataset
## hint: ?sample_n

# List the most visited news domains by the number of visits and 
# the number of unique users, in decreasing order of number of unique users

# Let's mark the most popular social network sites and search engines

# Count the share of social network sites and search engines among all visits

# Plot a time series of the daily number of visits over time

# Plot a time series of the daily number of visits and unique users over time
# in one plot with two facets/panels

# Calculate for each user the average ideology of her/his website visit


# Exercise 4: Getting started with text analysis ----

# Identify the visits whose URL contains "trump"
## hint: ?str_detect


