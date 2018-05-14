
library(httr)
library(purrr)
library(magrittr)
library(dplyr)
library(stringr)

setwd("/Users/ryanweber/Desktop/CUNY/Data 607 Db/Final Project")

api_key <- read.table(file = str_c(getwd(), "/NewsApiText.txt"), stringsAsFactors = FALSE)[1, 1]

articleDf <- NULL

getArticles <- function(site, page){
  
  print(str_c("Site: ", site, " - page: ", page))
  
  # Create URL
  url <- str_c("https://newsapi.org/v2/everything?language=en&sources=", site, 
               "&pagesize=100&from=2018-05-09&to=2018-05-13&apiKey=", api_key, 
               "&page=", page)
  
  # Get content
  articleList <- content(GET(url), "parse")
  
  # Parse relevant fields to df
  articleList$articles %>% map_df(extract, c("title", "publishedAt"))
}

# Retrieve articles from 5/9-5/13

# CNN
cnnList <- map(1:7, function(x) {getArticles("cnn", x)})

cnnDf <- map_df(cnnList, extract) %>%
  mutate(site = "cnn")

# Fox News
foxList <- map(1:9, function(x) {getArticles("fox-news", x)})

foxDf <- map_df(foxList, extract) %>%
  mutate(site = "fox")

# MSNBC
msnbcList <- map(c(1:4), function(x) {getArticles("msnbc", x)})

msnbcDf <- map_df(msnbcList, extract) %>%
  mutate(site = "msnbc")

newsApiDf <- bind_rows(cnnDf, foxDf, msnbcDf)

write.csv(newsApiDf, "/Users/ryanweber/Desktop/CUNY/Data 607 Db/NewApi.csv")
