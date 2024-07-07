# About the Project

Welcome to our platform! This project was proudly initiated by a Brooklyn College alumnus.

## Our Mission

Textbooks can be prohibitively expensive, forcing many students to opt for used ones each semester. Unfortunately, book resellers often exploit this demand by overpricing even second-hand books.

Our website aims to change that by:
- Providing a direct marketplace where students can buy and sell textbooks to each other
- Eliminating the need for third-party resellers
- Ensuring fair prices for all

Join us in creating a more affordable and student-friendly textbook exchange community.

---

## **Implementation:**

This Flask application is a simple web platform for managing user accounts and posting book-related content. It allows users to sign up, log in, create, update, and delete posts about books, including uploading book pictures.  

1. **User Authentication and Management**: Utilizes Flask-Login for handling user authentication, session management, and protecting routes to ensure only authenticated users can access certain pages. Users can sign up, log in, and log out. User passwords are encrypted using Flask-Bcrypt before being stored in the database.

2. **Form Handling**: Uses Flask-WTF to create forms for user sign-up, log in, and post creation. It includes validations to ensure data integrity, such as checking if a username or email already exists in the database during sign-up.

3. **Database Models**: SQLAlchemy is used as the ORM to define `User` and `Post` models, representing the application's data structure. The `User` model stores user information, while the `Post` model stores information about book posts, including title, department, content, and associated image file names.

4. **File Uploads**: Implements file handling to allow users to upload images for their book posts. It generates a unique filename for each upload to avoid conflicts and stores the files in a designated directory on the server.

5. **Web Pages and Routing**: Defines routes for various pages like the home page, about page, account page, and individual post pages. It uses Flask's `render_template` to serve HTML templates, passing data from the server, such as user information and posts, to the templates.

6. **Database Initialization**: At the start, it checks for the existence of the database and tables, creating them if they don't exist, using SQLAlchemy's `create_all` method within the Flask application context.

7. **Configuration**: Sets up necessary configurations for the Flask application, including the secret key for session management, database URI, and customizing the login view.

This application demonstrates a basic but comprehensive use of Flask and its extensions to build a web application with user authentication, form handling, file uploads, and database operations.

---

## How to install this project

#### Build and run Docker container

1. **Build the Docker image:**

    ```bash
    docker build -t book-finder-web-app .
    ```

    This command builds a Docker image from your Dockerfile and tags it (`-t`) as `book-finder-web-app`. The `.` at the end of the command tells Docker to look for the Dockerfile in the current directory.  

2. **Run the Docker container:**

    On your local machine, open a Python shell and run:
    ```bash
    > import secrets
    > print(secrets.token_hex(16))
    ```

    On server:
    ```bash
    $ docker run -d -p 5001:5001 --name book-finder-web-app --restart unless-stopped -e SECRET_KEY='your_generated_secret_key' book-finder-web-app
    ```

    `-d` runs the container in detached mode (in the background)
    `-p 5001:5001` maps port `5001` on the host to port `5001` in the container
    `--name book-finder-web-app` names the container
    `--restart unless-stopped` ensures the container restarts automatically unless it is explicitly stopped
    `book-finder-web-app` is the name of the image to run

3. **Access the running container:**

    ```bash
    $ docker ps
    $ docker exec -it <container: name || id> /bin/bash
    ```

    `-i` -- interactive mode
    `-t` -- TTY
---
