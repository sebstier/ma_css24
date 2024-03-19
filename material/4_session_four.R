#' class: "Computational Social Science and Digital Behavioral Data, University of Mannheim"
#' title: "Automated text analysis"
#' author: "Sebastian Stier"
#' lesson: 4
#' institute: University of Mannheim & GESIS
#' date: "2024-03-20"

library(tidyverse)

# Exercise 1: Analysis of the web tracking data ----
load("data/toy_browsing.rda")
load("data/toy_survey.rda")

# What are the top ten visited domains in the data?
## Install the R package adaR: https://cran.r-project.org/web/packages/adaR/adaR.pdf
## Apply the relevant function from the package to extract domains from URLs

# Summarize the number of Facebook visits per person

# Merge the web tracking data with the survey data

# Plot the relation of Facebook visits and age


# Exercise 2: Analysis of news website visits ----

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


# Exercise 3: Preprocessing and preparing text for analysis ----

# Identify the web tracking visits whose URL contains "trump"
## hint: ?str_detect


# Download the Trump Twitter Archive

# Download all tweets from the Trump Twitter archive and save the file
# in the folder "data"
# https://drive.google.com/file/d/1xRKHaP-QwACMydlDnyFPEaFdtskJuBa6/view

# Check if the tweet IDs are unique


# For more advanced text analysis, install the package quanteda

library(quanteda)

# Create a corpus of Trump tweets 
corp_trump <- corpus(df_trump, text_field = "text")
print(corp_trump)
docvars(corp_trump)
summary(corp_trump, 5)

# Subset corpus to tweets in the years 2019 and 2020
#corp_trump_subset <- 
range(corp_trump$date)
range(corp_trump_subset$date)

# Subset corpus to tweets in the year 2020 and that have more than 200.000 retweets

    
# Reshape the corpus from document-level to sentence-level
ndoc(corp_trump_subset)
corp_sentences <- corpus_reshape(corp_trump_subset, to = "sentences")
ndoc(corp_sentences)

# Count the number of tokens / words for each document
summary(corp_sentences, 5)
ntoken(corp_sentences)[1:5]
ntoken(corp_trump_subset)[1:5]
corp_sentences$word_count <- ntoken(corp_sentences)
summary(corp_sentences, 5)

# Keep only sentences with at least 5 words


# Next, we need to tokenize a corpus
toks <- tokens(corp_trump_subset)
print(toks)


# Apply some of the preprocessing options in ?tokens


# Keywords in context
kw_fake <- kwic(toks, pattern =  "fake*")
head(kw_fake, 15)

# Even more context
kw_fake2 <- kwic(toks, pattern = c("fake*", "democr*"), window = 7)
head(kw_fake2, 15)

# Sometimes we are looking for more than one word 
kw_multiword <- kwic(toks, pattern = phrase(c("fake news", "crazy nancy")))
head(kw_multiword, 15)

# Remove stopwords
toks_nostop <- tokens_select(toks, pattern = stopwords("en"), selection = "remove")
toks[6]
toks_nostop[6]

# Create our first document feature matrix (dfm)
dfm <- dfm(dict_toks)

# Create a dfm of the full corpus
dfm <- dfm(toks)

# Which are the most frequent words?
topfeatures(dfm, 10)

# remove stop words and again show the top features

# Use only words that appear at least 10 times
ncol(dfm)
dfm_trimmed <- dfm_trim(dfm, min_termfreq = 10)
ncol(dfm_trimmed)


# Exercise 4: Text analysis ----
library(quanteda.textmodels)
library(quanteda.textstats)
library(quanteda.textplots)
library(seededlda)

# trim the dfm to make modeling more efficient
#dfm_trimmed <- corp_trump %>% 


#* Frequency counts ----
?textstat_frequency


#* Dictionary analysis ----
?dictionary
dict <- dictionary(list(fake = c("fake", "fake news"),
                        democrats = c("democr*", "nancy"),
                        republicans = c("repub*", "gop"))
)
dfm_dict <- dfm_lookup(dfm_trimmed, dictionary = dict) 
dfm_dict <- dfm_lookup(dfm_trimmed, dictionary = dict, nomatch = "n_unmatched") %>% 
    dfm_group(device) 

# Plot on which device Trump talks about democrats and "fakes" 
dfm_dict %>% 
    convert("data.frame") %>%
    dplyr::rename(device = doc_id) %>%
    filter(n_unmatched > 1000) %>% 
    pivot_longer(-c(device, n_unmatched), names_to = "Topic") %>%
    mutate(Share = value / n_unmatched) %>% 
    ggplot(aes(x = device, y = Share, colour = Topic, fill = Topic)) +
    geom_bar(stat = "identity") +
    xlab("") +
    ylab("Share of words (%)")



#* Keyness analysis ----
dfm %>% 
    dfm_group(groups = isRetweet) %>% 
    textstat_keyness() %>% 
    textplot_keyness()


#* LDA topic model ----
tmod_lda <- textmodel_lda(dfm_trimmed, k = 10)
terms(tmod_lda, 10)

# Assign topic as a new variable
dfm_trimmed$topic <- topics(tmod_lda)

# cross-table the topic frequency
table(dfm_trimmed$topic)

