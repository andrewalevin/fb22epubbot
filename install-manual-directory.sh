#!/bin/bash

# Step 1: Create the project directory and navigate into it
echo "📂 Step 1: Creating project directory..."
mkdir -p fb22epubbot && cd fb22epubbot
echo "✅ Project directory created and navigated into."

# Step 2: Set up a virtual environment
echo "🐍 Step 2: Setting up virtual environment..."
python3 -m venv venv
source venv/bin/activate
echo "✅ Virtual environment set up and activated."

# Step 3: Install the fb22epubbot package
echo "📦 Step 3: Installing fb22epubbot package..."
pip install fb22epubbot
echo "✅ fb22epubbot package installed."
echo ""

# Step 4: Prompt the user for the BOT_TOKEN and store it in .env file
echo "Step 4:"
read -p "🔑 Insert BOT_TOKEN: " BOT_TOKEN
echo "BOT_TOKEN=$BOT_TOKEN" > .env
echo "✅ BOT_TOKEN saved to .env file."

# Step 5: Run the bot
echo "🤖 Step 5: Running the bot..."
fb22epubbot