#!/bin/bash

# File paths
file_path="topic.txt"
out_path="out.txt"
explanation_path="explanation.txt"
LANG="BASH"
BASE_URL="https://openrouter.ai/api/v1"

# Ensure API key is passed as an environment variable
if [ -z "$API_KEY" ]; then
    echo "Error: OPENROUTER_API_KEY is not set. Please set it as an environment variable."
    exit 1
fi

# Read content from the input file
topic=$(<"$file_path")
topic=$(echo "$topic" | tr -d '\n')

# Define the prompt for code generation
code_prompt="Write short code in $LANG with no comments to $topic"

# Call OpenRouter API to generate the code
code_response=$(curl -s -X POST "$BASE_URL/chat/completions" \
    -H "Authorization: Bearer $OPENROUTER_API_KEY" \
    -H "Content-Type: application/json" \
    -d "{\"model\": \"openrouter/auto\", \"messages\": [{\"role\": \"system\", \"content\": \"You are a helpful coding assistant that writes like an amateur and does not write comments.\"}, {\"role\": \"user\", \"content\": \"$code_prompt\"}]}" )

# Extract generated code
generated_code=$(echo "$code_response" | jq -r '.choices[0].message.content')

# Save generated code to the output file
echo "$generated_code" > "$out_path"

# Define the prompt for explanation
explanation_prompt="Explain the following $LANG code in simple terms:\n\n$generated_code"

# Call OpenRouter API to generate explanation
explanation_response=$(curl -s -X POST "$BASE_URL/chat/completions" \
    -H "Authorization: Bearer $OPENROUTER_API_KEY" \
    -H "Content-Type: application/json" \
    -d "{\"model\": \"openrouter/auto\", \"messages\": [{\"role\": \"system\", \"content\": \"You are a helpful assistant that explains code in simple terms.\"}, {\"role\": \"user\", \"content\": \"$explanation_prompt\"}]}" )

# Extract explanation text
explanation_text=$(echo "$explanation_response" | jq -r '.choices[0].message.content')

# Save explanation to a separate file
echo "$explanation_text" > "$explanation_path"

# Print status messages
echo "Code generated and saved to $out_path"
echo "Explanation saved to $explanation_path"
#!/bin/bash

# File paths
file_path="topic.txt"
out_path="out.txt"
explanation_path="explanation.txt"
LANG="BASH"
BASE_URL="https://openrouter.ai/api/v1"

# Ensure API key is passed as an environment variable
if [ -z "$API_KEY" ]; then
    echo "Error: OPENROUTER_API_KEY is not set. Please set it as an environment variable."
    exit 1
fi

# Read content from the input file
topic=$(<"$file_path")
topic=$(echo "$topic" | tr -d '\n')

# Define the prompt for code generation
code_prompt="Write short code in $LANG with no comments to $topic"

# Call OpenRouter API to generate the code
code_response=$(curl -s -X POST "$BASE_URL/chat/completions" \
    -H "Authorization: Bearer $OPENROUTER_API_KEY" \
    -H "Content-Type: application/json" \
    -d "{\"model\": \"openrouter/auto\", \"messages\": [{\"role\": \"system\", \"content\": \"You are a helpful coding assistant that writes like an amateur and does not write comments.\"}, {\"role\": \"user\", \"content\": \"$code_prompt\"}]}" )

# Extract generated code
generated_code=$(echo "$code_response" | jq -r '.choices[0].message.content')

# Save generated code to the output file
echo "$generated_code" > "$out_path"

# Define the prompt for explanation
explanation_prompt="Explain the following $LANG code in simple terms:\n\n$generated_code"

# Call OpenRouter API to generate explanation
explanation_response=$(curl -s -X POST "$BASE_URL/chat/completions" \
    -H "Authorization: Bearer $OPENROUTER_API_KEY" \
    -H "Content-Type: application/json" \
    -d "{\"model\": \"openrouter/auto\", \"messages\": [{\"role\": \"system\", \"content\": \"You are a helpful assistant that explains code in simple terms.\"}, {\"role\": \"user\", \"content\": \"$explanation_prompt\"}]}" )

# Extract explanation text
explanation_text=$(echo "$explanation_response" | jq -r '.choices[0].message.content')

# Save explanation to a separate file
echo "$explanation_text" > "$explanation_path"

# Print status messages
echo "Code generated and saved to $out_path"
echo "Explanation saved to $explanation_path"
