# Netflix Location Updater

*Netflix Location Updater* is an easy to use python script to automatically fetch the location update 
Email from an Email mailbox and click the confirmation link in it.
Script can easily run on a Raspberry Pi.

## Features

- Automatically polling of Email mailbox for given polling intervall
- Netflix Email fetching and automatically household confirmation
- Moving the Netflix Email into a separate subfolder of mailbox
- Logging file with info and error messages

## Quickstart

Basic installation instruction

### Prerequisites

As the script uses selenium to interact with the browser, the chromedriver is needed.
Please download the correct chromedriver for your current Chrome version from here:
https://chromedriver.chromium.org/downloads
Specify the path to the chromedriver executable in the config.ini file.

Alternatively, the chromedriver-py package can be used to automatically download the latest chromedriver.
To do so, set the *UseChromedriverPy = True* option in the config.ini file.

### Installation

To install all dependencies, simply install the requirements first:

    python -m pip install -r requirements.txt

### Usage

Make sure to fill out the config.ini file with the correct parameters for the Email mailbox, first!

To run the script, simply execute the following command:

    python netflix_location_update.py

The script will run in an infinite loop and polls the Email mailbox with the default polling time of 2 seconds.
The script can be aborted by pressing **Ctrl + C**

### Installation on Raspberry Pi

To start the script at the startup of Raspberry Pi, crontab can be used. 
For the following commands, it is assumed that the default user *pi* exists. If not, replace the username with the correct one'
The easiest way ist to use SSH connection and execute the following commands:

    cd /home/pi
    git clone ...
    cd netflix-location-update
    python -m venv .venv
    .venv/bin/pip install -r requirements.txt

Now update all the parameters in the config.ini with your own Email provider data.
Start the script and check if it runs without errors.
If everything works, break with **CTRL + C**

Edit crontab:

    crontab -e

Select nano as editor. Go to the end of the file and add the following line:

    @reboot /home/pi/netflix-location-update/netflix-location-update-launcher.sh &

Save with **CTRL + X**, **Y** and finally press **Return**
Now restart the Raspberry Pi:

    sudo reboot

The script should now be started after each startup and runs in an infinite loop.