library(rtweet)

token <- create_token(
  app = Sys.getenv("app_name"),
  consumer_key = Sys.getenv("consumer_key"),
  consumer_secret = Sys.getenv("consumer_secret"),
  access_token = Sys.getenv("access_token"),
  access_secret = Sys.getenv("access_secret")
)

api_message <- try(jsonlite::fromJSON("https://api.tradestatistics.io/"))

if (substr(api_message, 1, 11) == "Hello World") {
  topic <- c("Data", "Data visualization", "Computing", "Statistics")
  topic_sample <- sample(topic,1)
  quote <- statquotes::statquote(topic = topic_sample)
  
  tweet <- glue::glue(
    '"{quote$text}"
    \u2014 {quote$source}.
    Posted by using rtweet::'
  )
  
  while (nchar(tweet) > 280) {
    topic_sample <- sample(topic,1)
    quote <- statquotes::statquote(topic = topic_sample)
    
    tweet <- glue::glue(
      '"{quote$text}"
      \u2014 {quote$source}.
      Posted by using rtweet::'
    )
  }
  
  post_tweet(status = tweet, token = token)
}
