library(tidyr)
library(dplyr)

setwd("/Users/ryanweber/Desktop/CUNY/Data 607 Db/Final Project/")

temp = list.files(path = str_c(getwd(), "/Scraped Headlines/"), pattern="*.csv")
myfiles = lapply(temp, function(x) {read.csv(str_c(getwd(), "/Scraped Headlines/", x), stringsAsFactors = FALSE, colClasses = "character")})
myfiles <- myfiles[10:length(myfiles)]

df <- NULL

df <- map_df(myfiles, bind_rows)

# Remove "(CNN)"
df$featuredArticleText <- str_replace_all(df$featuredArticleText, "\\(CNN\\)", "")

# Replace all these special characters of the form <U.....> with '
df <- df %>% transmute_all(funs(str_replace_all(., "<U\\+[:alnum:]+>", "'")))

# Remove "Breaking news"-type identifiers
df$mainPage <- str_replace_all(df$mainPage, "\\[Breaking.+\\]", "")
df$mainPage <- str_replace_all(df$mainPage, "Breaking News", "Breaking News ")

# Add spaces between "wordNext word" type combinations
df$mainPage <- gsub("([a-z]{2})([A-Z])", "\\1 \\2", df$mainPage)
df$mainPage <- gsub("([A-Z]{2}'?)([A-Z][a-z])", "\\1 \\2", df$mainPage)
df$mainPage <- gsub("([A-Z]{2})([0-9])", "\\1 \\2", df$mainPage)

# Remove "SEPARATOR" text which had been left in between when some of the vectors were collapsed
df$mainPage <- gsub("SEPARATOR", " ", df$mainPage)

# Remove time stamps that occurred in some articles
df$mainPage <- str_replace_all(df$mainPage, "[:digit:][:digit:]?\\:[:digit:]{2}", " ")

# Create headlines that concatenate the intro type text that appears before the headline in some sites (cnn, fox)
df$kickerHeadline1 <- str_c(df$kicker1, " ", df$headline1)
df$kickerHeadline2 <- str_c(df$kicker2, " ", df$headline2)
df$kickerHeadline3 <- str_c(df$kicker3, " ", df$headline3)

# Convert from wide to long format
df <- df %>%
  select(-X) %>%
  gather("Field", "Text", 3:length(.))

# Only keep those resuls that parsed properly (removes about 200 rows where site had been improperly stored)
df <- df %>% filter(site %in% c("cnn", "fox", "msnbc"))

# Save out results
write.csv(df, str_c(getwd(), "/cleanedHeadlines.csv"))
