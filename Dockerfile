FROM python:3.7

WORKDIR /src

COPY pyproject.toml /src
COPY uv.lock /src

COPY --from=ghcr.io/astral-sh/uv:0.6.14 /uv /uvx /bin/
RUN uv python install 3.7
RUN uv --managed-python pip install -r pyproject.toml 

EXPOSE  8080
CMD ["python3", "/src/main.py"]
