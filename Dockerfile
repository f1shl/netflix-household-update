FROM selenium/standalone-chrome

WORKDIR /app

USER root
RUN wget https://bootstrap.pypa.io/get-pip.py
RUN python3 get-pip.py
RUN python3 -m pip install selenium

COPY requirements.txt /app
RUN python3 -m pip install -r requirements.txt

COPY config.ini /app
COPY netflix_household_update.py /app

CMD ["python3", "netflix_household_update.py"]
