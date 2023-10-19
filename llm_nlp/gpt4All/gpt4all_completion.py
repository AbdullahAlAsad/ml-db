import json
import re
from gpt4all import GPT4All
import pandas as pd


def parse_quoted_words(sentence):
    quoted_words = re.findall(r'"([^"]*)"', sentence)
    return quoted_words


gptj = GPT4All("ggml-gpt4all-j-v1.3-groovy")
# messages = [{"role": "user", "content": "Name 3 colors"}]
# gptj.chat_completion(messages)
# "What are the three most relevant action words that describe the main idea, sentiment, and any mentioned name in this tweet?.\njhoome jo rinkuuuuu baby atrinkusingh235 atnitishrana 27 amp atvenkateshiyer beauties remember believe thats congratulations atkkriders atvenkymysore take care heart sir https co xbvq85fd09\n"
# test_tweet2 = "What are the three most relevant action words that describe the main idea, sentiment, and any mentioned name in this tweet?.\npehle aap nahin pehle app download knightclub app https co n6ynmsksqr"
# messages = [{"role": "user", "content": test_tweet2}]
# gptj.chat_completion(messages,verbose=False)

# test_tweet3 = "What are the three most relevant action words that describe the main idea, sentiment, and any mentioned name in this tweet?.\nsuccess maybe excitement guaranteed\n"
# messages = [{"role": "user", "content": test_tweet3}]
# gptj.chat_completion(messages,verbose=False)

prompts = [
    {
        "model": "text-davinci-003",
        "prompt": "What are the three most relevant action words that describe the main idea, sentiment, and any mentioned name in this tweet?.\natbillym2k lot ways ai go wrong\n",
    }
]
# count = 0;
# df = pd.DataFrame(columns=['Prompt', 'Output'])
# with open(f'data/request_topic.jsonl','r') as file:
#     for line in file.__iter__():
#         # count = count +1
#         # if(count == 2):
#         #     break
#         text = line.strip()
#         raw_json = json.loads(text)
#         prompt = raw_json['prompt']
#         messages = [{"role": "user", "content": prompt}]
#         response = gptj.chat_completion(messages, verbose=False,streaming=False)
#         content = response['choices'][0]['message']['content']
#         parsed_words = parse_quoted_words(content)
#         start_index = prompt.find("\n") + 1
#         end_index = prompt.rfind("\n")
#         extracted_part = prompt[start_index:end_index]
#         df.loc[len(df.index)] = [extracted_part,parsed_words]

# print(df.head())
# df.to_csv('data/topics.csv', index=False)

# for prompt in prompts:
#     messages = [{"role": "user", "content": prompt["prompt"]}]
#     gptj.chat_completion(messages, verbose=False)

promptMap = {
    "model": "text-davinci-003",
    "prompt": "The word \"always kind friend let us meet sooner soon bless\" belongs in which of the following categories: 1. Personal Information 2. Current Events 3. Hobbies and Interests 4. Entertainment 5. Travel 6. Food and Dining 7. Health and Fitness 8. Relationships 9. Work and Career 10. Education 11. Culture and Society 12. Sports and Recreation 13. Personal Growth and Development 14. Fashion and Style 15. Home and Family 16. Technology and Gadgets 17. Art and Creativity 18. Pets and Animals 19. Philosophy and Ethics 20. Nature and Environment ?\n",
}
# {"model": "text-davinci-003", "prompt": "Classify the following words into one of the following categories: 1. Personal Information 2. Current Events 3. Hobbies and Interests 4. Entertainment 5. Travel 6. Food and Dining 7. Health and Fitness 8. Relationships 9. Work and Career 10. Education 11. Culture and Society 12. Sports and Recreation 13. Personal Growth and Development 14. Fashion and Style 15. Home and Family 16. Technology and Gadgets 17. Art and Creativity 18. Pets and Animals 19. Philosophy and Ethics 20. Nature and Environment Word: Believe\n"}
# {"model": "text-davinci-003", "prompt": "Classify the following words into one of the following categories: 1. Personal Information 2. Current Events 3. Hobbies and Interests 4. Entertainment 5. Travel 6. Food and Dining 7. Health and Fitness 8. Relationships 9. Work and Career 10. Education 11. Culture and Society 12. Sports and Recreation 13. Personal Growth and Development 14. Fashion and Style 15. Home and Family 16. Technology and Gadgets 17. Art and Creativity 18. Pets and Animals 19. Philosophy and Ethics 20. Nature and Environment Word: Congratulations\n"}

# messages = [{"role": "user", "content": promptMap["prompt"]}]
# gptj.chat_completion(messages, verbose=False)
# gptj.generate(promptMap["prompt"])


#   Find sentiments  ----- ---- ---- ---- ------ ------ 
# count = 0;
# df = pd.DataFrame(columns=['Prompt', 'Output'])
# with open(f'data/requests_BarackObama_sentiment.jsonl','r') as file:
#     for line in file.__iter__():
#         count = count +1
#         if(count == 101):
#             break
#         text = line.strip()
#         raw_json = json.loads(text)
#         prompt = raw_json['prompt']
#         messages = [{"role": "user", "content": prompt}]
#         response = gptj.chat_completion(messages, verbose=False,streaming=False)
#         content = response['choices'][0]['message']['content']
#         print(content)
#         parsed_words = parse_quoted_words(content)
#         print(parsed_words)
#         start_index = prompt.find("\n") + 1
#         end_index = prompt.rfind("\n")
#         extracted_part = prompt[start_index:end_index]
#         df.loc[len(df.index)] = [extracted_part,parsed_words]

# print(df.head())
# df.to_csv('data/result_BarackObama_sentiment.csv', index=False)

# 9.58
# 11.00

def extract_sentiment(inputPath, outputPath):
    #   Find sentiments  ----- ---- ---- ---- ------ ------ 
    count = 0;
    df = pd.DataFrame(columns=['Prompt', 'Output'])
    with open(inputPath,'r') as file:
        for line in file.__iter__():
            count = count +1
            if(count == 101):
                break
            text = line.strip()
            raw_json = json.loads(text)
            prompt = raw_json['prompt']
            messages = [{"role": "user", "content": prompt}]
            response = gptj.chat_completion(messages, verbose=False,streaming=False)
            content = response['choices'][0]['message']['content']
            print(content)
            parsed_words = parse_quoted_words(content)
            print(parsed_words)
            start_index = prompt.find("\n") + 1
            end_index = prompt.rfind("\n")
            extracted_part = prompt[start_index:end_index]
            df.loc[len(df.index)] = [extracted_part,parsed_words]

    print(df.head())
    df.to_csv(outputPath, index=False)


# extract_sentiment("data/requests_cnnbrk_sentiment.jsonl","data/result_cnnbrk_sentiment.csv")

def extract_topic(inputPath, outputPath):
    count = 0;
    df = pd.DataFrame(columns=['Prompt', 'Output'])
    with open(inputPath,'r') as file:
        for line in file.__iter__():
            count = count +1
            if(count == 100):
                break
            text = line.strip()
            raw_json = json.loads(text)
            prompt = raw_json['prompt']
            messages = [{"role": "user", "content": prompt}]
            response = gptj.chat_completion(messages, verbose=False,streaming=False)
            content = response['choices'][0]['message']['content']
            parsed_words = parse_quoted_words(content)
            start_index = prompt.find("\n") + 1
            end_index = prompt.rfind("\n")
            extracted_part = prompt[start_index:end_index]
            df.loc[len(df.index)] = [extracted_part,parsed_words]

    print(df.head())
    df.to_csv(outputPath, index=False)

# extract_topic("data/requests_narendramodi_topic.jsonl","data/result_narendramodi_topic.csv")

def extract_class(inputPath, outputPath):
    count = 0;
    df = pd.DataFrame(columns=['Prompt', 'Output'])
    with open(inputPath,'r') as file:
        for line in file.__iter__():
            count = count +1
            if(count == 1000):
                break
            text = line.strip()
            raw_json = json.loads(text)
            prompt = raw_json['prompt']
            messages = [{"role": "user", "content": prompt}]
            response = gptj.chat_completion(messages, verbose=False,streaming=False)
            content = response['choices'][0]['message']['content']
            parsed_words = parse_quoted_words(content)
            start_index = prompt.find("\n") + 1
            end_index = prompt.rfind("\n")
            extracted_part = prompt[start_index:end_index]
            df.loc[len(df.index)] = [extracted_part,parsed_words]

    print(df.head())
    df.to_csv(outputPath, index=False)