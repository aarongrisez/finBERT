FROM pytorch/pytorch:1.1.0-cuda10.0-cudnn7.5-runtime

WORKDIR /src

COPY pyproject.toml /src
COPY uv.lock /src

COPY --from=ghcr.io/astral-sh/uv:0.6.14 /uv /uvx /bin/
RUN uv python install 3.7
RUN uv pip install -r pyproject.toml --managed-python

EXPOSE  8080
CMD ["python3", "/src/main.py"]
