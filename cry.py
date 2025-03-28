from openai import OpenAI

# File paths
file_path = r"topic.txt"
out_path = r"out.txt"
explanation_path = r"explanation.txt"
LANG = "PYTHON"

# Read content from the input file
with open(file_path, 'r') as file:
    content = file.read().strip()

# Configure OpenRouter API
client = OpenAI(
    base_url="https://openrouter.ai/api/v1",
    api_key="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",  # Replace with your actual API key
)

# Define the prompt for code generation
code_prompt = f"Write short code in {LANG} with no comments to {content}"

# Call OpenRouter API to generate the code
code_response = client.chat.completions.create(
    model="openrouter/auto",
    messages=[
        {"role": "system", "content": "You are a helpful coding assistant and cryptography expert that writes like an amateur and does not write comments."},
        {"role": "user", "content": code_prompt}
    ],
  
)

# Extract generated code
generated_code = code_response.choices[0].message.content

# Save generated code to the output file
with open(out_path, 'w') as file:
    file.write(generated_code)

# Define the prompt for explanation
explanation_prompt = f"Explain the following {LANG} code in simple terms:\n\n{generated_code}"

# Call OpenRouter API to generate explanation
explanation_response = client.chat.completions.create(
    model="openrouter/auto",
    messages=[
        {"role": "system", "content": "You are a helpful assistant that explains code in simple terms."},
        {"role": "user", "content": explanation_prompt}
    ],
    
)

# Extract explanation text
explanation_text = explanation_response.choices[0].message.content

# Save explanation to a separate file
with open(explanation_path, 'w') as file:
    file.write(explanation_text)

print(f"Code generated and saved to {out_path}")
print(f"Explanation saved to {explanation_path}")
