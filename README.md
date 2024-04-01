# Netflix Household Updater

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

### Installation

To install all dependencies, simply install the requirements first:

    python -m pip install -r requirements.txt

### Usage

Make sure to add required credential to your environment variables correct parameters for the Email mailbox, first!
The options for the variables are:
Required:
- `IMAP_SERVER` - The IMAP server from which to poll Netflix emails. (e.g. `imap.gmail.com`) 
- `IMAP_USER` - The login username for your IMAP server 
- `IMAP_PASS` - The login passsword for your IMAP server (for gmail, you might need to create an "App Password")
- `NETFLIX_USER` - The login username for your Netflix account
- `NETFLIX_PASS` - The login password for your Netflix password
  
  Optional:
- `POLLING_TIME_IN_SECONDS` - (Default: 2) - Frequency in seconds on how often to check for Netflix emails in the specified mailbox.
- `IMAP_PORT` - (Default: 993) - The port for your IMAP server.
- `MAILBOX_NAME` - (Default: INBOX) - The mailbox folder name from which to poll Netflix emails
- `MoveEmailsToMailbox` - (Default: True) - Enables moving confirmed/processed Netlix emails to a separate mail folder
- `MoveToMailboxName` - (Default: Netflix) - If the option above is enabled, this specifies the folder name where to move the processed emails.

To run the script, simply execute the following command:

    python netflix_household_update.py

The script will run in an infinite loop and polls the Email mailbox with the default polling time of 2 seconds.
The script can be aborted by pressing **Ctrl+C**

### Installation on Raspberry Pi

To start the script at the startup of Raspberry Pi, crontab can be used. 
For the following commands, it is assumed that the default user *pi* exists. If not, replace the username with the correct one'
The easiest way ist to use SSH connection and execute the following commands:

    cd /home/pi
    git clone https://github.com/f1shl/netflix-household-update.git
    cd netflix-household-update
    python -m venv .venv
    .venv/bin/pip install -r requirements.txt

Now update all the parameters in the config.ini with your own Email provider data.
Start the script and check if it runs without errors.
If everything works, break with **CTRL+C**

Edit crontab:

    crontab -e

Select nano as editor. Go to the end of the file and add the following line:

    @reboot /home/pi/netflix-household-update/netflix-household-update-launcher.sh &

Save with **CTRL+X**, **Y** and finally press **Return**
Now restart the Raspberry Pi:

    sudo reboot

The script should now be started after each startup and runs in an infinite loop.

### Launch on Docker
First, you need to build the container using:
`docker build -t [docker-image-name]:latest .`

docker run --name [docker-container-name] \
            -e IMAP_SERVER=[imap-server] \
            -e IMAP_USER=[imap-user] \
            -e IMAP_PASS=[imap-password] \
            -e NETFLIX_USER=[netflix-username] \
            -e NETFLIX_PASS=[netflix-passsword] \
            [docker-image-name]:latest

Or run in with Docker-Compose:
```
version: '3.8'

services:
    netflix-updater:
      container_name: netflix-updater
      image: [docker-image-name]:latest
      restart: unless-stopped
      environment:
        - IMAP_SERVER=[imap-server]
        - IMAP_USER=[imap-user]
        - IMAP_PASS=[imap-password]
        - NETFLIX_USER=[netflix-username]
        - NETFLIX_PASS=[netflix-passsword]
```
