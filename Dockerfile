# Use official Jupyter PySpark notebook image
FROM jupyter/pyspark-notebook:latest

# Switch to root for configuration
USER root

# Configure Jupyter (remove token for local development)
RUN echo "c.NotebookApp.token = ''" >> /home/jovyan/.jupyter/jupyter_notebook_config.py && \
    echo "c.NotebookApp.password = ''" >> /home/jovyan/.jupyter/jupyter_notebook_config.py

# Switch back to jovyan user
USER jovyan

# Set working directory
WORKDIR /home/jovyan/work