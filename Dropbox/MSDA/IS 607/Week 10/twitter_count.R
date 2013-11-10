#assuming you have already authenticated a twitteR session

library(plyr)
library(stringr)
library(ggplot)

beer.tweets = searchTwitter("#beer",n=180, cainfo="cacert.pem")

beer.text = laply(beer.tweets,function(twt) twt$getText())


#there are many regex patterns to identify hashtags in a tweet
#pattern = "\\B#\\w\\w+"
#pattern = "\\S*#(?:\\[[^\\]]+\\]|\\S+)"
pattern = "#\\w*[a-zA-Z]+\\w*"

#a functions that returns # of hashtags
hashtagcount = function(string)
{
  require(stringr)
    
  return (str_count(string, pattern))
  
}


#a function to return which hashtag is htag 
#i.e in tweet ("#football #beer #nygiants #nfl"), this would return 2 for htag = "#beer"
position_of_hashtag = function(string, htag)
{
  require(stringr)
  
  hashtags = str_extract_all(string,pattern)
  hashtags = str_split(hashtags[[1]]," ")
  
  return(match(htag,tolower(hashtags)))
}


cnthashtag = laply(.data=beer.text,.fun=hashtagcount)
beerpos = laply(.data=beer.text,.fun=position_of_hashtag,htag="#beer")

twtbeerdf = data.frame(beerpos=beerpos,cnthashtag=cnthashtag,beertext = beer.text)

twtbeer_summary = ddply(
  twtbeerdf,
  .(cnthashtag, beerpos),
  summarize,
  count=length(beerpos)
)

ggplot(twtbeer_summary, aes(cnthashtag, beerpos, size=count)) +
  geom_point() + scale_size_area() + geom_abline(intercept = 1, slope = 0, color="red")
#the red line in the plot is where the #beer hashtag is the first hashtag in a tweet
