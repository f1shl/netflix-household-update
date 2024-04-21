FROM selenium/standalone-chrome

WORKDIR /app

USER root
RUN wget https://bootstrap.pypa.io/get-pip.py
RUN python3 get-pip.py
COPY requirements.txt /app
RUN python3 -m pip install -r requirements.txt

COPY netflix_household_update.py /app

ENTRYPOINT ["python3", "netflix_household_update.py"]
