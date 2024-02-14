# Dagster libraries to run both dagster-webserver and the dagster-daemon. Does not
# need to have access to any pipeline code.

FROM python:3.10-slim

# Set $DAGSTER_HOME and copy dagster instance and workspace YAML there
ENV DAGSTER_HOME=/opt/dagster/dagster_home/
RUN mkdir -p $DAGSTER_HOME
WORKDIR $DAGSTER_HOME
COPY requirements.txt $DAGSTER_HOME
RUN pip install --no-cache-dir -r $DAGSTER_HOME/requirements.txt && \
    groupadd -r dagster && useradd -m -r -g dagster dagster && \
    chown -R dagster:dagster $DAGSTER_HOME
WORKDIR $DAGSTER_HOME

RUN mkdir -p /opt/dagster/app

COPY dagster.yaml $DAGSTER_HOME
COPY . /opt/dagster/app

WORKDIR /opt/dagster/app

CMD ["dagster-webserver", "-h", "0.0.0.0", "-p", "3000"]
