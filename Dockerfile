# Use an official Python runtime as a parent image
FROM python:3.12.2-slim

# Set the working directory in the container to /app-server
WORKDIR /app-server

# Copy the current directory . in the project to the workdir . in the image
COPY . .

# Install any needed packages specified in requirements.txt
RUN pip3 install --no-cache-dir -r requirements.txt

# Make port 5000 available to the world outside this container
EXPOSE 5001

# Set environment variables required by Flask command
ENV FLASK_APP=app.py
ENV FLASK_RUN_HOST=0.0.0.0
ENV FLASK_ENV=development
ENV FLASK_DEBUG=1

# Run the command to start Flask server
CMD ["flask", "run", "--host=0.0.0.0", "--port=5001"]