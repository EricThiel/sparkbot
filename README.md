# This has moved to https://github.com/securenetwrk/sparkbot-base - Please use that instead.

# Generic Spark Bot

This is the a Spark Bot as a basic proof of concept

The application was designed to provide a simple demo for Cisco Spark.  It is written as a simple Python Flask application and deployed as a docker container.

**NOTE: To leverage the Spark Bot Service, your server MUST be accessible from the public Internet.  This is because it relies on the Spark Cloud to be able to send a WebHook to the spark application you run***


# Spark Developer Account Requirement
In order to use this service, you will need a Cisco Spark Account to use for the bot.  It is recommended you create an "App" at https://developer.ciscospark.com/apps.html so that messages to the bot are not mixed with normal messages.
Creating an account is free and only requires a working email account (each Spark Account needs a unique email address).  Visit [http://www.ciscospark.com](http://www.ciscospark.com) to signup for an account.

Developer access to Spark is also free and information is available at [http://developer.ciscospark.com](http://developer.ciscospark.com).

In order to access the APIs of Spark, this bot needs the Developer Token for your account.  To find it:

* Go to [http://developer.ciscospark.com](http://developer.ciscospark.com) and login with the credentials for your account.
* In the upper right corner click on your picture and click `Copy` to copy your Access Token to your clipboard
* Make a note of this someplace for when you need it later in the setup
  * **If you save this in a file, such as in the `Vagrantfile` you create later, be sure not to commit this file.  Otherwise your credentials will be availabe to anyone who might look at your code later on GitHub.**

For purposes of this sample the bot is set up to only respond to messages from users with email addresses @cisco.com via either direct message or by mentioning the bot in a room listed in variable active_rooms.

## Basic Application Details

Required

* flask
* ArgumentParser
* requests

# Environment Installation

    pip install -r requirements.txt

# Basic Usage

In order to run, the service needs several pieces of information to be provided:

* Spark Bot Authentication Key to Require in API Calls
* Spark Bot URL
* Spark Account Details
  * Spark Account Email
  * Spark Account Token

These details can be provided in one of three ways.

* As a command line argument

	```
	python sparkbot1/sparkbot1.py \
	  --secret "BOT AUTH KEY" \
	  --boturl "http://spark.server.com" \
	  --botemail "my.demo@server.com" \
	  --token "HAAKJ1231KFSDFKJSDF1232132"
	```
  
* As environment variables

	```
	export spark_bot_email=my.demo@server.com`
	export spark_token=HAAKJ1231KFSDFKJSDF1232132`
	export spark_bot_url=http://spark.server.com`
	export spark_bot_secret="BOT AUTH KEY"`
	export active_rooms="1234abcd1234abcd,abcd1234abcd1234"`
	python sparkbot1/sparkbot1.py`
	```

* As raw input when the application is run

	```
	python sparkbot1/sparkbot1.py`
	What is the app server address? http://app.server.com`
	App Server Key: APP AUTH KEY`
	 .
	 .
	
	```

A command line argument overrides an environment variable, and raw input is only used if neither of the other two options provide needed details.

When launching in a container, copy sparkbot1.env.sample to sparkbot1.env and change the values. Then include --env-file sparkbot1/sparkbot1.env in your docker run command to read in the values.

# Accessing

Upon startup, the service registers a webhook to send all new messages to the service address.


## Interacting with the Spark Bot
The Spark Bot is a very simple interface that is designed to make it intuitive to use.  Simply send any message to the Spark Bot Email Address to have the bot reply back with some instructions on how to access the features.

The bot is deisgned to look for commands to act on, and provide the basic help message for anything else.  The commands are:

* /invite <teamname>
  * invite a user to a team named <teamname>
* /inviteroom <roomname>
  * invite a user to a room named <roomname>
* /help
  * Provide a help message

## REST APIs

The main service API is at the root of the application and is what is used for the Spark Webhooks.


