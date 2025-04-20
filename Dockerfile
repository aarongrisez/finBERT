FROM pytorch/pytorch:1.1.0-cuda10.0-cudnn7.5-runtime

WORKDIR /src

COPY pyproject.toml /src
COPY uv.lock /src

RUN uv pip install -r pyproject.toml

EXPOSE  8080
CMD ["python3", "/src/main.py"]
