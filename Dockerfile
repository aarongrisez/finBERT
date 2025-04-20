FROM pytorch/pytorch:1.1.0-cuda10.0-cudnn7.5-runtime

WORKDIR /src

COPY pyproject.toml /src
COPY uv.lock /src

RUN curl -LsSf https://astral.sh/uv/install.sh | sh
RUN source $HOME/.local/bin/env (sh, bash, zsh)
RUN uv python install 3.7
RUN uv pip install -r pyproject.toml

EXPOSE  8080
CMD ["python3", "/src/main.py"]
