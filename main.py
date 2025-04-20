from flask import Flask
from flask_cors import CORS
import sys
import optparse
import time
from flask import request
import sys
from finbert.finbert import predict
from pytorch_pretrained_bert.modeling import BertForSequenceClassification
import nltk
import os
import praw
import json

nltk.download('punkt')
app = Flask(__name__)
CORS(app)
start = int(round(time.time()))
model = BertForSequenceClassification.from_pretrained('/src/models/classifier_model/finbert-sentiment', num_labels=3, cache_dir=None)

with open("keys.json", "r") as f:
    keys = json.loads(f.read())

    reddit = praw.Reddit(
        client_id = keys["CLIENT_ID"],
        client_secret = keys["CLIENT_SECRET"],
        user_agent = keys["USER_AGENT"]
    )

@app.route("/",methods=['POST'])
def score():
    text=request.get_json()['text']
    return(predict(text, model).to_json(orient='records'))

@app.route("/r/<subreddit_name>", methods=['GET'])
def scan_subreddit(subreddit_name):
    """
    Scans the given subreddit for financial signals. Looks at the last 24 hours
    of posts and comments, returning ticker symbols and overall user sentiment.
    """
    return "empty"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080, debug=False, threaded=True)
