FROM python:3.10-buster

WORKDIR /undorse

RUN apt update && apt upgrade -y

COPY poetry.lock .
COPY pyproject.toml .
RUN python -m pip install poetry
RUN poetry export > requirements.txt
RUN pip install -r requirements.txt gunicorn

COPY . /undorse

ENTRYPOINT ["gunicorn", "--workers=3", "-b", "0.0.0.0:8000", "undorse:app"]

