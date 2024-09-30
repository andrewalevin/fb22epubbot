#!/bin/bash

# Create the project directory and navigate into it
mkdir -p fb22epubbot && cd fb22epubbot

# Set up a virtual environment
python3 -m venv venv
source venv/bin/activate

# Install required packages
pip install fb22epubbot

# Prompt the user for the BOT_TOKEN and store it in .env file
read -p "🔑 Insert BOT_TOKEN: " BOT_TOKEN
echo "BOT_TOKEN=$BOT_TOKEN" > .env

# Run the bot
fb22epubbot