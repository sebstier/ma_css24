#' class: "Computational Social Science and Digital Behavioral Data, University of Mannheim"
#' title: "Introduction"
#' author: "Sebastian Stier"
#' lesson: 1
#' institute: University of Mannheim & GESIS
#' date: "2023-02-14"

# Exercise 0: Install [R](https://cran.rstudio.com) and [RStudio Desktop](https://posit.co/downloads/) ----

# Exercise 1: Setup and R packages ----
## a. Create a folder for the R scripts and materials of this class and set the R working directory to this folder.

## b. Create folders "data" and "plots"

## c. Install the R package *tidyverse*. 

## d. Check the version of the *tidyverse* package

## e. List all your files in the working directory and the environment (top right)


# Exercise 2: Transform a data frame into a tibble and list the major differences between the two formats. ----




# Exercise X: Explore a toy web tracking dataset ----

# Load the test browsing data
filename <- "data/toydt_browsing.rda"
download.file(url = "https://osf.io/download/wjd7g/", destfile = filename)
load(filename)

# Load the test survey data
filename <- "data/toydt_survey.rda"
download.file(url = "https://osf.io/download/jyfru/", destfile = filename)
load(filename)


# First, let's get a feeling for the data: How many participants are in the data?

# What is the number of website visits per participant?
    
# How many of the visits happened on mobile and on desktop?    
    
# What is the time range of the data?

# What are the top ten visited domains in the data?
## Install the R package adaR: https://cran.r-project.org/web/packages/adaR/adaR.pdf
## Apply the function to extract domains from URLs

# Summarize number of Facebook visits per person

# Merge the web tracking data with the survey data

# Plot the relation of Facebook visits and age


