require(RSelenium)
library(dplyr)
library(rvest)

currentTime <- Sys.time()

browser <- rsDriver()

# Assign the client
remDr <- browser$client

# Establish a wait for an element
remDr$setImplicitWaitTimeout(1000)

appurl <- "https://www.foxnews.com"
remDr$navigate(appurl)

# Give a crawl delay to see if it gives time to load web page
Sys.sleep(10)    # Been testing with 10


# Fox

doc_fox <- read_html(remDr$getPageSource()[[1]])

Sys.sleep(10) 

# Breaking news
breakingNews_fox <- doc_fox %>%
  html_nodes(xpath = "//div[contains(concat(' ', normalize-space(@class), ' '), ' alert-title ')]//a") %>%
  html_text()

breakingNews_fox

# Extract Headlines
headline1_fox <- doc_fox %>%
  html_nodes(xpath = "//div[contains(concat(' ', normalize-space(@class), ' '), ' collection-spotlight ')]//article[@class='article story-1']//header[@class='info-header']/*[@class='title']/a") %>%
  html_text()

headline1_fox 

kicker1_fox <- doc_fox %>%
  html_nodes(xpath = "//div[contains(concat(' ', normalize-space(@class), ' '), ' collection-spotlight ')]//article[@class='article story-1']//span[@class='kicker-text']") %>%
  html_text()

kicker1_fox 

link1_fox <- doc_fox %>%
  html_nodes(xpath = "//div[contains(concat(' ', normalize-space(@class), ' '), ' collection-spotlight ')]//article[@class='article story-1']//header[@class='info-header']/*[@class='title']//a//@href") %>%
  html_text()

link1_fox 

# Second headline
headline2_fox <- doc_fox %>%
  html_nodes(xpath = "//div[contains(concat(' ', normalize-space(@class), ' '), ' collection-spotlight ')]//article[@class='article story-2']//header[@class='info-header']/*[@class='title']/a") %>%
  html_text()

headline2_fox 

kicker2_fox <- doc_fox %>%
  html_nodes(xpath = "//div[contains(concat(' ', normalize-space(@class), ' '), ' collection-spotlight ')]//article[@class='article story-2']//span[@class='kicker-text']") %>%
  html_text()

kicker2_fox

# Third headline
# webElem <- remDr$findElements(using = "xpath", "//div[contains(concat(' ', normalize-space(@class), ' '), ' collection-spotlight ')]//article[@class='article story-3']//header[@class='info-header']/*[@class='title']/a")
# headline3 <- unlist(lapply(webElem, function(x){x$getElementText()}))
# print(headline3)

headline3_fox <- doc_fox %>%
  html_nodes(xpath = "//div[contains(concat(' ', normalize-space(@class), ' '), ' collection-spotlight ')]//article[@class='article story-3']//header[@class='info-header']/*[@class='title']/a") %>%
  html_text()

headline3_fox

kicker3_fox <- doc_fox %>%
  html_nodes(xpath = "//div[contains(concat(' ', normalize-space(@class), ' '), ' collection-spotlight ')]//article[@class='article story-3']//span[@class='kicker-text']") %>%
  html_text()

kicker3_fox

# Main story text
mainPage_fox <- doc_fox %>%
  html_nodes(xpath = "//div[contains(concat(' ', normalize-space(@class), ' '), ' main-primary ')]") %>%
  html_text()

mainPage_fox

# Navigate to Expedia.com
appurl <- link1_fox #"http://www.foxnews.com/us/2018/05/06/hawaiis-volcanic-eruption-has-destroyed-at-least-26-homes-officials-say.html"
remDr$navigate(appurl)

# Give a crawl delay to see if it gives time to load web page
Sys.sleep(10)   # Been testing with 10

# Fox

doc_fox_f <- read_html(remDr$getPageSource()[[1]])

Sys.sleep(10) 

featuredArticleText_fox <- doc_fox_f %>%
  html_nodes(xpath = "//div[contains(concat(' ', normalize-space(@class), ' '), ' article-body ')]//p") %>%
  html_text()

featuredArticleText_fox
  
  
# add in "alert title"


# cnn
appurl <- "https://www.cnn.com"
remDr$navigate(appurl)

# Give a crawl delay to see if it gives time to load web page
Sys.sleep(10)   # Been testing with 10

doc_cnn <- read_html(remDr$getPageSource()[[1]])

Sys.sleep(10)

# Breaking news
breakingNews_cnn <- doc_cnn %>%
  html_nodes(xpath = "//div[contains(concat(' ', normalize-space(@class), ' '), ' breaking-news ')]//div[contains(concat(' ', normalize-space(@class), ' '), ' breaking-news__msg ')]//a") %>%
  html_text()

breakingNews_cnn

# Extract Headlines
mainHeadline_cnn <- doc_cnn %>%
  html_nodes(xpath = "//div[contains(concat(' ', normalize-space(@class), ' '), ' zn__containers ')]//li//article//*[contains(concat(' ', normalize-space(@class), ' '), ' banner-text ')]") %>%
  html_text()

mainHeadline_cnn


topHeadlines_cnn <- doc_cnn %>%
  html_nodes(xpath = "//section[contains(concat(' ', normalize-space(@class), ' '), ' zn-homepage1-zone-1 ')]//*[contains(concat(' ', normalize-space(@class), ' '), ' cd__headline ')]//*[contains(concat(' ', normalize-space(@class), ' '), ' cd__headline-text ')]//strong") %>%
  html_text()

topHeadlines_cnn

mainPage1_cnn <- doc_cnn %>%
  html_nodes(xpath = "//section[contains(concat(' ', normalize-space(@class), ' '), ' zn-homepage1-zone-1 ')]//*[contains(concat(' ', normalize-space(@class), ' '), ' cd__headline ')]//*[contains(concat(' ', normalize-space(@class), ' '), ' cd__headline-text ')]") %>%
  html_text()

mainPage1_cnn

linkPage1_cnn <- doc_cnn %>%
  html_nodes(xpath = "//section[contains(concat(' ', normalize-space(@class), ' '), ' zn-homepage1-zone-1 ')]//*[contains(concat(' ', normalize-space(@class), ' '), ' cd__headline ')]//a/@href") %>%
  html_text()

link1_cnn <- paste0("https://www.cnn.com", linkPage1_cnn[1])

mainPage2_cnn <- doc_cnn %>%
  html_nodes(xpath = "//section[contains(concat(' ', normalize-space(@class), ' '), ' zn-homepage2-zone-1 ')]//*[contains(concat(' ', normalize-space(@class), ' '), ' cd__headline ')]//*[contains(concat(' ', normalize-space(@class), ' '), ' cd__headline-text ')]") %>%
  html_text()

mainPage2_cnn

mainPage_cnn <- c(mainPage1_cnn, mainPage2_cnn)

appurl <- link1_cnn

remDr$navigate(appurl)

# Give a crawl delay to see if it gives time to load web page
Sys.sleep(10)    # Been testing with 10

doc_cnn_f <- read_html(remDr$getPageSource()[[1]])

Sys.sleep(10)

featuredArticleText_cnn <- doc_cnn_f %>%
  html_nodes(xpath = "//section[contains(concat(' ', normalize-space(@class), ' '), ' zn-body-text ')]//*[contains(concat(' ', normalize-space(@class), ' '), ' zn-body__paragraph ')]") %>%
  html_text() 

featuredArticleText_cnn


# msnbc
# 
appurl <- "https://www.msnbc.com"
remDr$navigate(appurl)

# Give a crawl delay to see if it gives time to load web page
Sys.sleep(10)    # Been testing with 10

doc <- read_html(remDr$getPageSource()[[1]])

Sys.sleep(10)

# Extract Headlines
headlines_msnbc <- doc %>%
  html_nodes(xpath = "//span[contains(concat(' ', normalize-space(@class), ' '), ' featured-slider-menu__item__link__title ')]") %>%
  html_text()

headlines_msnbc 

# headlines_links <- doc %>%
#   html_nodes(xpath = "//a[contains(concat(' ', normalize-space(@class), ' '), ' featured-slider-menu__item__link ')]//@href") %>%
#   html_text()
# 
# headlines_links 



df <- data.frame(site = c("fox", "cnn", "msnbc"),
                 currentTime = rep(currentTime, 3),
                 alert = c(paste(breakingNews_fox, sep="_", collapse="SEPARATOR"), 
                           paste(breakingNews_cnn, sep="_", collapse="SEPARATOR"), ""), 
                 kicker1 = c(paste(kicker1_fox, sep="_", collapse="SEPARATOR"),
                             paste(mainHeadline_cnn, sep="_", collapse="SEPARATOR"), ""),
                 headline1 = c(paste(headline1_fox, sep="_", collapse="SEPARATOR"),
                               topHeadlines_cnn[1],
                               headlines_msnbc[1]),
                 kicker2 = c(paste(kicker2_fox, sep="_", collapse="SEPARATOR"),
                            "", ""),
                 headline2 = c(paste(headline2_fox, sep="_", collapse="SEPARATOR"),
                               topHeadlines_cnn[2],
                               headlines_msnbc[2]),
                 kicker3 = c(paste(kicker3_fox, sep="_", collapse="SEPARATOR"),
                             "", ""),
                 headline3 = c(paste(headline3_fox, sep="_", collapse="SEPARATOR"),
                               topHeadlines_cnn[3],
                               headlines_msnbc[3]),
                 mainPage = c(paste(mainPage_fox, sep="_", collapse="SEPARATOR"),
                              paste(mainPage_cnn, sep="_", collapse=" "),
                              paste(headlines_msnbc, sep="_", collapse="SEPARATOR")), 
                 featuredArticleText = c(paste(featuredArticleText_fox, sep="_", collapse=" "),
                                         paste(featuredArticleText_cnn, sep="_", collapse=" "),
                                         ""), 
                 stringsAsFactors = FALSE)


write.csv(df, file=paste0("/Users/ryanweber/Desktop/CUNY/Data 607 Db/Final Project/news_", currentTime, ".csv"))

remDr$close()
remDr$quit()

quit(save="no")




