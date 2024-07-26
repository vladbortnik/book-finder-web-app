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

# Set environment variables (optional)
ENV FLASK_ENV=production
ENV FLASK_DEBUG=0

# Run the command to start Flask server
CMD ["gunicorn", "-w", "4", "-b", "0.0.0.0:5001", "app:app"]