from pytorch/pytorch:1.1.0-cuda10.0-cudnn7.5-runtime

WORKDIR /src

COPY . /src

RUN conda env create -f environment.yml && conda activate finbert

EXPOSE  8080
CMD ["python3", "/src/main.py"]
