FROM python:2-alpine
EXPOSE 5000

# Install basic utilities
RUN apk add -U \
        ca-certificates \
  && rm -rf /var/cache/apk/* \
  && pip install --no-cache-dir \
          setuptools \
          wheel

# This is failing for some odd pip upgrade error commenting out for now
#RUN pip install --upgrade pip

COPY requirements.txt /app/
RUN pip install -r /app/requirements.txt

WORKDIR /app
ADD ./sparkbot1 /app/sparkbot1

CMD [ "python", "./sparkbot1/sparkbot1.py" ]

