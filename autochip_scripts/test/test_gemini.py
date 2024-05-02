import os
import google.generativeai as genai
import google.ai.generativelanguage_v1beta as genlang

genai.configure(api_key=os.getenv('GEMINI_API_KEY'))

#for m in genai.list_models():
#    if 'generateContent' in m.supported_generation_methods:
#        print(m.name)

model = genai.GenerativeModel('gemini-pro')

## history = [
##     genlang.Content(
##         role = "user",
##         parts = [genlang.Part(text = "Hello, how are you?")]
##     ),
##     genlang.Content(
##         role = "model",
##         parts = [genlang.Part(text = "I'm doing fine, thank you.")]
##     )
## ]
##
## chat = model.start_chat(history=history)
## response = chat.send_message('What are you doing?')
## print(response.text)
## print(response)
## print(type(chat.history[0]))

messages = [{'role':'', 'parts': ['hello','how are you?']}]
response = model.generate_content(messages)
print(response.candidates[0].content.parts[0].text)
