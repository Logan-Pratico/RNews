library(rvest)
library(dplyr)
library(magrittr)
library(stringr)
library(purrr)
library(here)
library(tidyRSS)
library(rmarkdown)
library(formatR)

urls <- c(
  "https://rss.nytimes.com/services/xml/rss/nyt/HomePage.xml", # NYT
  "https://rss.nytimes.com/services/xml/rss/nyt/World.xml",
  "https://rss.nytimes.com/services/xml/rss/nyt/Science.xml",
  "https://rss.nytimes.com/services/xml/rss/nyt/Technology.xml",
  #"https://www.vox.com/rss/index.xml", # VOX
  "https://news.google.com/rss/search?q=when:24h+allinurl:reuters.com&ceid=US:en&hl=en-US&gl=US", # Reuters
  "https://news.google.com/rss/search?q=when:24h+allinurl:apnews.com&hl=en-US&gl=US&ceid=US:en", # AP
  "https://news.google.com/rss/search?q=when:24h+allinurl:theatlantic.com&hl=en-US&gl=US&ceid=US:en", # Atlantic
  "https://news.google.com/rss/search?q=when:24h+allinurl:newyorker.com&hl=en-US&gl=US&ceid=US:en", # New Yorker
  "http://feeds.bbci.co.uk/news/rss.xml#", # BBC
  "http://feeds.bbci.co.uk/news/world/rss.xml",
  "http://feeds.bbci.co.uk/news/politics/rss.xml",
  "http://feeds.bbci.co.uk/news/science_and_environment/rss.xml",
  "http://feeds.bbci.co.uk/news/technology/rss.xml",
  "https://news.google.com/rss/search?q=when:24h+allinurl:jacobinmag.com&hl=en-US&gl=US&ceid=US:en", # Jacobin
  "https://news.google.com/rss/search?q=when:24h+allinurl:time.com&hl=en-US&gl=US&ceid=US:en", # TIME
  "https://news.google.com/rss/search?q=when:24h+allinurl:cnn.com&hl=en-US&gl=US&ceid=US:en", # CNN
  "https://news.google.com/rss/search?q=when:24h+allinurl:wired.com&hl=en-US&gl=US&ceid=US:en", # WIRED
  "https://news.google.com/rss/search?q=when:24h+allinurl:independent.co.uk&hl=en-US&gl=US&ceid=US:en" # Independent
)






vec1 <- c("COVID", "virus", "pandemic", "vaccine", "COVID_News")
vec2 <- c(" AI ", "Artificial Intelligence", "Neural Networks", "Deep Learning", "AI_News")
vec3 <- c("quantum computing", "quantum computers", "quantum internet", "Quantum_News")
vec4 <- c(
  "Clean Energy", "Solar Power", "wind power", "fossil fuels", "coal",
  "green new deal", "Energy_News"
)
vec5 <- c("QAnon", "Fake news", "misinformation", "disinformation", "Disinformation_News")
vec6 <- c("Biden", "Trump", "Congress", "Impeachment", "Supreme Court", "Political_News")

keyWordsList <- list(vec1, vec2, vec3, vec4, vec5, vec6)

i <- 1
while (i < length(keyWordsList)) {
  commandArgs <- unlist(keyWordsList[i])
  source(here("RScripts", "article_scan.R"))
  i <- i + 1
}

rmarkdown::render(here("RScripts", "News.Rmd"), "pdf_document", here("output", Sys.Date(), "News"))

# source(here("RScripts", "News.rmd"))
