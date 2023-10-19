import os
import pandas as pd
import snscrape.modules.twitter as twitter
import json

def srape_tweet_profile_data(username):
    for i, tweet in enumerate(twitter.TwitterProfileScraper(username).get_items()):
        user = tweet.user
        break
    return user

def scrape_tweet_data(username):

    # Define the URL of the user's profile page
    # url = "https://twitter.com/" + username

    # Get the user profile information

    # for i, tweet in enumerate(twitter.TwitterProfileScraper(username).get_items()):
    #     user = tweet.user
    #     print(user.username)
    #     print(user.displayname)
    #     if(i==0):
    #         break
    # profile = srape_tweet_profile_data(username)
    # print(profile.followersCount)

    DATASET_COLUMNS = ['tweetDate', 'userId', 'userName', 'tweetId', 'tweetText', 'retweetedTweet', 'quotedTweet',
                       'hashtag', 'replyCount', 'retweetCount', 'likeCount', 'viewCount']
    attributes_container = []
    tweet_count = 5000
    # text_query = "iamsrk"
    # since_date = "2023-01-01"
    # until_date = "2023-05-29"
    # for i, tweet in enumerate(twitter.TwitterProfileScraper(username).get_items()):
    for i, tweet in enumerate(twitter.TwitterUserScraper(username).get_items()):
    # for i, tweet in enumerate(twitter.TwitterSearchScraper(text_query + ' since:'+since_date+' until:'+until_date+' lang:"en" ').get_items()):
    # for i, tweet in enumerate(twitter.TwitterSearchScraper(text_query + ' since:'+since_date+' until:'+until_date+' lang:"en" ').get_items()):
        if (i == tweet_count):
            break
        print(tweet.rawContent)
        # print(type(tweet.quotedTweet) )
        qt = tweet.quotedTweet
        # print(qt)
        # if (qt is not None):
        #     # d_list = json.loads(qt)
        #     # snscrape.modules.twitter.Tweet qtweet = qt
        #     print(qt.id)
        # print d_list.get('id')
        rt = tweet.retweetedTweet
        # print(rt)
        attributes_container.append(
            [tweet.date, tweet.user.id, tweet.user.username, str(tweet.id), tweet.rawContent, rt, qt, tweet.hashtags,
             tweet.replyCount, tweet.retweetCount, tweet.likeCount, tweet.viewCount])
    tweets_df = pd.DataFrame(attributes_container, columns=DATASET_COLUMNS)
    print(tweets_df.head)
    tweets_df.to_csv('output/{}-tweeter-posts.csv'.format(username), index=False,header=True)


scrape_tweet_data("elonmusk")
scrape_tweet_data("iamsrk")
scrape_tweet_data('KamalaHarris')
scrape_tweet_data('imessi')
scrape_tweet_data('BarackObama')
scrape_tweet_data('justinbieber')
scrape_tweet_data('Cristiano')
scrape_tweet_data('narendramodi')
scrape_tweet_data('realDonaldTrump')
scrape_tweet_data('cnnbrk')

#  ---------------------------------------------------------------------------------------------------------

# tweet_user = srape_tweet_profile_data("elonmusk")
# print(tweet_user.json())

#  ----------------------------------------------------------------------------------------------------------

# with open('output/elonmusk-profile.json', 'w') as json_file:
#     json_file.write(tweet_user.json())
# df = pd.read_json(tweet_user.json(),orient='index')
# print(df)
# df.to_csv('output/{}-tweeter-profile.csv'.format('elonmusk'), index=False,header=True)
# options = csv_to_sqlite.CsvOptions(typing_style="full", encoding="windows-1250")
# input_files = ['output/{}-tweeter-profile.csv'.format('iamsrk')] # pass in a list of CSV files
# csv_to_sqlite.write_csv(input_files, "output/output.sqlite", options)