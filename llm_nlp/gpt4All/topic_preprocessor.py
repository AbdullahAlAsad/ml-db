# import json

# def getTopicAndSentiment(content):
    
#     list_of_dicts = content
#     for d in list_of_dicts:
#         for k, v in d.items():
#             if isinstance(v, str):
#                 d[k] = v.replace("'", '"')
#     json_str = json.dumps(list_of_dicts)
    
#     json_obj = json.loads(json_str) # Parse the JSON string into a Python object
#     resultArray = []
#     if len(json_obj) > 0:
#         text = json_obj[0]['text'] # Access the value of the 'text' key in the first element of the list
#         # text = text.strip()
#         lines = text.split('\n') # Split the text into lines using '\n' as the separator
#         # print(f'json_obj-0-text == {text}')
#         # print(len(lines))
#         # print(lines)
#         topic = 'none'
#         sentiment = 'undefined'
#         if len(lines) > 1:
#             topicLines = lines[1].split(': ')
#             if len(topicLines) > 1:
#                 topic = topicLines[1]  # Extract the topic from the second line of the text
#             else:
#                 topic = lines[1]
#             # topic = lines[1].split(': ')[1] # Extract the topic from the second line of the text
#         if len(lines) > 2:
#             sentimentLines = lines[2].split(': ')
#             if len(sentimentLines) > 1:
#                 sentiment = sentimentLines[1]  # Extract the sentiment from the third line of the text
#             # sentiment = lines[2].split(': ')[1] # Extract the sentiment from the third line of the text
#         # print('Topic==', topic)
#         # print('Sentiment==', sentiment)
#         resultArray.extend([topic,sentiment])
#     else:
#         print('JSON object is empty')
#     return resultArray



# import json
# import pandas as pd
# username = "elonmusk"
# # username = "iamsrk"
# clean_data = []
# topics = []
# with open('data/topics.csv','r') as file:
#     for line in file.__iter__():
#         text = line.strip()
#         raw_json = json.loads(text)
#         # print(raw_json)
#         df = pd.DataFrame(raw_json)
#         # print(df.shape)
#         # showTabulatedDf(df)
# #         extract clean data
#         clean = df['prompt'][0]
#         clean = getCleanText(clean)
#         clean_data.append(clean)
#         # print(clean_data)
# #         extract topic and sentiment
#         topic = df['choices'][1]
#         topicSentiment = getTopicAndSentiment(topic)
#         topics.append(topicSentiment[0])
#         sentiments.append(topicSentiment[1])
#         # print(topics)
#         # print(sentiments)
# data = {'clean':clean_data,'topic':topics, 'sentiment':sentiments}
# df2 = pd.DataFrame(data) 
# # showTabulatedDf(df2)
# print('clean-topic-sentiment df')
# print(df2.shape)
# # jobs = df['clean'].apply(lambda row: {"model": "text-davinci-003", "prompt": str(pormpt_prefix+row) + "\n"})
# # ra/gpt_model/elonmusk__tweets.csv
# df1 = pd.read_csv('elonmusk_tweets_2023-04-15.csv')
# print(df1.shape)
# # showTabulatedDf(df1)

# merged_df = pd.merge(df1,df2, left_on='clean',right_on='clean',how='right')
# print(merged_df.head())
# # df['clean'] = tweet_df['rawContent'].apply(lambda row: clean_text(row))
# # merged_df.to_csv('raw_tweet_data/{}-tweets-with-topics-sentiment.csv'.format(username), index=False)
# unique_merged_df = merged_df.drop_duplicates(subset=['id','clean'])
# # unique_merged_df.to_csv('raw_tweet_data/{}-tweets-with-topics-sentiment.csv'.format(username), index=False)
# print('merged-df')
# print(merged_df.shape)
# print('unique_merged_df')
# print(unique_merged_df.shape)

import pandas as pd

# Read the CSV file into a pandas DataFrame
df = pd.read_csv('data/result_narendramodi_topic.csv')

# Split the "Output" column into a list of strings
df['Output'] = df['Output'].apply(eval)

# Create an empty list to store the expanded rows
expanded_rows = []

# Iterate over each row in the DataFrame
for index, row in df.iterrows():
    prompt = row['Prompt']
    output_list = row['Output']
    
    # Create a new row for each item in the output list
    for item in output_list:
        expanded_rows.append({'Prompt': prompt, 'Item': item})

# Create a new DataFrame from the expanded rows
expanded_df = pd.DataFrame(expanded_rows)

# Print the expanded DataFrame
print(expanded_df)