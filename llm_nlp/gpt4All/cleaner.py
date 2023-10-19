import string
import re
from nltk.corpus import stopwords
import json
import pandas as pd
# nltk.download('stopwords')
stop_words = set(stopwords.words('english'))

def clean_text(text):
    text = str(text).lower()
    text = text.replace('@', 'at')
    pat = r"[{}]".format(string.punctuation) 
    text = re.sub(pat, ' ', text) 
    text = re.sub('  +', ' ', text) 
    text = re.sub('https?://|www\.', '', text)  
    text = re.sub('\n', '', text)
    # text = re.sub('\w*\d\w*', '', text) 
    # print(text)
    # text = text.replace(u'\ud800', '')
    # text = text.replace('\x80', '?')
    # text = text.translate({i: None for i in range(128, 256)})
    # fixed_text = fix_nonascii(text)
    text = re.sub(r'[^\x00-\x7f]',r'',text)
    # text = fixed_text
    # print(text)
    
    # remove stopwords
    text = ' '.join([word for word in text.split() if word not in stop_words])
    if len(text) == 0:
        text = " "
    return text

def prepared_data():
    df = pd.read_csv('output/BarackObama-tweeter-posts.csv')