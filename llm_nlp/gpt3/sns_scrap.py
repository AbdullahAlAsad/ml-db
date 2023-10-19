import os
import sys
import snscrape.modules.twitter as sntwitter
import pandas as pd
import json

Username = "elonmusk"
SINCE = "2023-01-01"
UNTIL = "2023-05-29"
PLATFORM_NAME = os.environ.get('PLATFORM_NAME')


scraper = sntwitter.TwitterSearchScraper(f"(from:{Username}) until:{UNTIL} since:{SINCE}")
tweets = []
for i, tweet in enumerate(scraper.get_items()):
    print(tweet)
    # data=[tweet.id,tweet.content,tweet.user.username,tweet.likeCount,tweet.retweetCount,tweet.replyCount]
    data = {
        "id_post": tweet.id,
        "Date": tweet.date.strftime("%Y-%m-%d"),
        "Heure": tweet.date.strftime("%H:%M:%S"),
        "content": tweet.content,
        "username": tweet.user.username,
        "likecount": tweet.likeCount,
        "retweetcount": tweet.retweetCount,
        "replycount": tweet.replyCount,
        "platformname": PLATFORM_NAME

    }
    tweets.append(data)
    if i > 8:
        break

tweet_df = pd.DataFrame(tweets, columns=["id_post","Date","Heure", "content", "username", "likecount", "reteweetcount", "replycount","platformname"])
tweet_df.to_csv('tweeter-29-elonmusk.csv', sep=";", encoding='utf-8', index=False)

tweet_json = tweet_df.to_json(orient='records', indent=4)
print(tweet_json.encode('utf-8').decode('utf-8'))

import snscrape.modules.twitter as sntwitter
import pandas as pd


tweets = []

for i,tweet in enumerate(sntwitter.TwitterSearchScraper(query = "#opportunity").get_items()):
    if i>10:
        break
    tweets.append([tweet.user.username, tweet.date, tweet.likeCount, tweet.retweetCount, tweet.replyCount, tweet.lang,
                   tweet.sourceLabel, tweet.content])