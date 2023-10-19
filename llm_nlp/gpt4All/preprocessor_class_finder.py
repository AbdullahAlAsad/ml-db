import json
import pandas as pd
import nltk
from cleaner import clean_text
# from nltk.corpus import stopwords

# nltk.download('stopwords')
# stop_words = set(stopwords.words('english'))
# nltk.download('stopwords')

df = pd.read_csv('data/post_topic_sentiment/modi_post_topic_sentiment.csv')
filename = "data/modi_class.jsonl"
n_requests = 10000
# pormpt_prefix = "Find the topic and sentiment(positive, negative, nutral) from the following social media content.\n\n"
pormpt_prefix = "Classify the following words into one of the following categories: 1. Personal Information 2. Current Events 3. Hobbies and Interests 4. Entertainment 5. Travel 6. Food and Dining 7. Health and Fitness 8. Relationships 9. Work and Career 10. Education 11. Culture and Society 12. Sports and Recreation 13. Personal Growth and Development 14. Fashion and Style 15. Home and Family 16. Technology and Gadgets 17. Art and Creativity 18. Pets and Animals 19. Philosophy and Ethics 20. Nature and Environment Word: \n"
# pormpt_prefix = "The single action word(positive, negative, neutral) that describe the sentiment in this tweet is = ?.\n"
# prompt = f"Tweet: \"{}\"\n\nPrompt: What is the main idea, sentiment and any mention of a name in the tweet?\n\nOutput:\n\nIdea: \nSentiment: \nName: "
# prompt = f"Twitter post: \"{}\"
# \nPrompt: Summarize, Evaluate, Identify\nMain Idea: Summarize\nSentiment: Evaluate\nName: Identify"
# input_sentence = pormpt_prefix + sentence
# jobs = [{"model": "text-davinci-003", "input": str(x) + "\n"} for x in range(n_requests)]
# jobs = df['rawContent'].apply(lambda row: {"model": "text-embedding-ada-002", "prompt": str(pormpt_prefix+row) + "\n"})
df['clean'] = df['word'].apply(lambda row: clean_text(row))
jobs = df['clean'].apply(lambda row: {"prompt": str(pormpt_prefix+row) + "\n"})
# jobs = df['clean'].apply(lambda row: {"model": "text-davinci-003", "prompt": f"Tweet: \"{row}\"\n\nPrompt: What is the main idea, sentiment and any mention of a name in the tweet?\n\nOutput:\n\nIdea: \nSentiment: \nName: "})
count = 0
with open(filename, "w") as f:
    for job in jobs:
        # job = job.replace('\x80', '?')
        count = count + 1
        json_string = json.dumps(job)
        f.write(json_string + "\n")
        if(count==n_requests):
            break