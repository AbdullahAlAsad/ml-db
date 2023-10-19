from gpt4all import GPT4All

def new_text_callback(text):
    print(text, end="")

model = GPT4All('ggml-gpt4all-l13b-snoozy.bin')
# model.generate("Once upon a time, ", n_predict=55, new_text_callback=new_text_callback)
for token in model.generate("What are the three most relevant action words that describe the main idea, sentiment, and any mentioned name in this tweet?.\njhoome jo rinkuuuuu baby atrinkusingh235 atnitishrana 27 amp atvenkateshiyer beauties remember believe thats congratulations atkkriders atvenkymysore take care heart sir https co xbvq85fd09\n"):
        print(token, end='', flush=True)