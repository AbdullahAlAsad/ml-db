import snscrape.modules.twitter as sntwitter
count = 0;
for tweet in sntwitter.TwitterUserScraper("iamsrk", maxEmptyPages=1000).get_items():
    print(tweet.json)
    print('-----------------------')
    print(tweet)
    count = count + 1
    if(count==1):
        break