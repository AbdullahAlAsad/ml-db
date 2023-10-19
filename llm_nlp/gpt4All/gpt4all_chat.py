import openai


openai.api_base = "http://localhost:4891/v1"
#openai.api_base = "https://api.openai.com/v1"

openai.api_key = "not needed for a local LLM"

# Set up the prompt and other parameters for the API request
prompt = "Who is Michael Jordan?"

# model = "gpt-3.5-turbo"
#model = "mpt-7b-chat"
model = "gpt4all-j-v1.3-groovy"

# Make the API request
response = openai.Completion.create(
    model=model,
    prompt=prompt,
    max_tokens=50,
    temperature=0.28,
    top_p=0.95,
    n=1,
    echo=True,
    stream=False
)

# Print the generated completion
print(response)

# /home/asad/workspace/gpt4all/gpt4all-chat/CMakeLists.txt:42: error: By not providing "FindQt6.cmake" in CMAKE_MODULE_PATH this project has asked CMake to find a package configuration file provided by "Qt6", but CMake did not find one. Could not find a package configuration file provided by "Qt6" (requested version 6.5) with any of the following names: Qt6Config.cmake qt6-config.cmake Add the installation prefix of "Qt6" to CMAKE_PREFIX_PATH or set "Qt6_DIR" to a directory containing one of the above files.  If "Qt6" provides a separate development package or SDK, be sure it has been installed.