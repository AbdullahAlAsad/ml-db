from langchain import PromptTemplate, LLMChain
from langchain.llms import GPT4All
from langchain import LLMChain, OpenAI, PromptTemplate
from langchain.callbacks.base import CallbackManager
from langchain.callbacks.streaming_stdout import StreamingStdOutCallbackHandler

local_path = 'ggml-gpt4all-l13b-snoozy.bin' 
# local_path = '/home/asad/.cache/gpt4all/ggml-gpt4all-l13b-snoozy.bin'
callback_manager = CallbackManager([StreamingStdOutCallbackHandler()])

template = """Question: {question}

Answer: Let's think step by step on it.

"""

prompt = PromptTemplate(template=template, input_variables=["question"])
llm = GPT4All(model="ggml-gpt4all-l13b-snoozy.bin", n_ctx=512, n_threads=8)
# llm = GPT4All(model=local_path, callback_manager=callback_manager, verbose=True)
llm_chain = LLMChain(prompt=prompt, llm=llm)
# llm = LLMChain(llm=OpenAI(), prompt=prompt)

# Hardcoded question
question = "What Formula 1 pilot won the championship in the year Leonardo di Caprio was born?"

# User imput question...
#question = input("Enter your question: ")

llm_chain.run(question)