#' class: "Computational Social Science and Digital Behavioral Data, University of Mannheim"
#' title: "Automated text analysis"
#' author: "Sebastian Stier"
#' lesson: 6
#' institute: University of Mannheim & GESIS
#' date: "2024-04-17"

library(tidyverse)
library(quanteda)

# Set the WD to the folder where the script is located
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

# Load the Trump tweets
# Read in the file, specifying that "id" is a string, because as numbers 
#the IDs were corrupted
df_trump <- read_csv("data/tweets_01-08-2021.csv", col_types = "ccllcddTl")

# Create a dfm
corp_trump <- corpus(df_trump, text_field = "text", docid_field = "id")

# Subset trump corpus to year 2019
# corp_trump_subset <- 
toks <- tokens(corp_trump_subset)
toks <- tokens(toks, remove_punct = TRUE, remove_numbers = TRUE)
toks_nostop <- tokens_select(toks, pattern = c(stopwords("en"), "rt"), selection = "remove")
dfm <- dfm(toks_nostop)

# Exercise 1: Text analysis ----
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
    ggplot(aes(x = device, y = Share, color = Topic, fill = Topic)) +
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

# Cross-table the topic frequency
table(dfm_trimmed$topic)

#* Supervised machine learning ----

# GOAL: we train and evaluate a Naive Bayes classifier 

# Download the nytimes dataset from http://www.amber-boydstun.com/supplementary-information-for-making-the-news.html

# Load the dataset into R
df_nyt <- read_csv("data/boydstun_nyt_frontpage_dataset_1996-2006_0_pap2014_recoding_updated2018.csv")

# Let's look up the categories in the codebook
#http://www.amber-boydstun.com/uploads/1/0/6/5/106535199/nyt_front_page_policy_agendas_codebook.pdf

# Inspect the distribution of topics
table(df_nyt$majortopic)

# Turn the NY Times dataframe into a dfm

# Trim the number of features to a manageable size

# Train the model and evaluate performance
modell.NB <- textmodel_nb(dfm_trimmed, df_nyt$majortopic, prior = "docfreq")

prop.table(table(predict(modell.NB) == df_nyt$majortopic))
prop.table(table(sample(predict(modell.NB)) == df_nyt$majortopic))*100



# Exercise 2: Introduction to network analysis ----
# install.packages("remotes")
# remotes::install_github("schochastics/networkdata")
library(networkdata)
library(igraph)
library(ggraph)
library(graphlayouts)

# Create our own network / graph
# Adjacency matrix
A <- matrix(c(0, 1, 1, 3, 0, 2, 1, 4, 0),
            nrow = 3, ncol = 3, byrow = TRUE)
rownames(A) <- colnames(A) <- c("Bob", "Ann", "Steve")
A

# Create an igraph object and plot for first inspection
g1 <- graph_from_adjacency_matrix(A, mode = "undirected")
g1
plot(g1)

# Load example datasets 
data(package = "networkdata") # check out example network datasets 
data("flo_marriage")
data("got") # Game of Thrones dataset

#* Network visualization ----
# Choose one of the networks (Game of Thrones season 1)
gotS1 <- got[[1]]

# Compute a clustering for node colors
V(gotS1)$clu <- as.character(membership(cluster_louvain(gotS1)))

# Compute degree as node size
V(gotS1)$size <- degree(gotS1)

# Define colors
# define a custom color palette
got_palette <- c("#1A5878", "#C44237", "#AD8941", "#E99093",
                 "#50594B", "#8968CD", "#9ACD32")

# Plot
ggraph(gotS1, layout = "stress") +
    geom_edge_link0(aes(edge_linewidth = weight), edge_colour = "grey66") +
    geom_node_point(aes(fill = clu, size = size), shape = 21) +
    geom_node_text(aes(filter = size >= 26, label = name), family = "serif") +
    scale_fill_manual(values = got_palette) +
    scale_edge_width(range = c(0.2, 3)) +
    scale_size(range = c(1, 6)) +
    theme_graph() +
    theme(legend.position = "none")



# Exercise 3: Recap of data wrangling with some web tracking data ----
list.files("data")
load("data/toy_browsing.rda")
load("data/toy_survey.rda")


# Let's mark the most popular social network sites and search engines

# Count the share of social network sites and search engines among all visits

# Plot a time series of the daily number of visits over time

# Plot a time series of the daily number of visits and unique users over time
# in one plot with two facets/panels

# Calculate for each user the average ideology of her/his website visit


