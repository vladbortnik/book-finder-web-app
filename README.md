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

Simple, yet, comprehensive **`Flask Web App`** for managing User Accounts and Posting Book-Related content. The app is containerized using **`Docker`**, ensuring a Consistent and Isolated Runtime Environment. For production deployment, the app is served using **`Gunicorn`**, (a Python WSGI HTTP Server), which provides a robust and efficient way to handle multiple requests.

1. **User Authentication and Management**: 
   - Utilizes **`Flask-Login`** for handling User Authentication, Session Management, and Protecting Routes to ensure only Authenticated Users can access certain pages.
   - Users can Sign up & Log in, with Passwords Securely Encrypted using **`Flask-Bcrypt`** before its Hash being Stored in the Database.

2. **Form Handling**:
   - Uses **`Flask-WTF`** to create forms for User Sign-up, Log in, and Post creation.
   - Includes Validations to ensure Data Integrity, such as checking if a Username or Email already exists in the Database during sign-up.

3. **Database Models**:
   - `SQLAlchemy` is used as the ORM to define User and Post models, representing the application's Data Structure.
   - The User model stores user information, while the Post model stores information about book posts, including title, department, content, and associated image file names.

4. **File Uploads**:
   - Implements file handling to allow users to upload images for their book posts.
   - Generates a Unique Filename for each upload to avoid conflicts and stores the files in a designated directory on the Server.

5. **Web Pages and Routing**:
   - Defines routes for various pages like the home page, about page, account page, and individual post pages.
   - Uses Flask's `render_template` to serve HTML templates, passing data from the server, such as user information and posts, to the templates.
   - **Responsive Design**: Implements Bootstrap to ensure responsive design, making the web application accessible and user-friendly across various devices and screen sizes.

6. **Database Initialization**:
   - At the start, it checks for the Existence of the Database and Tables, creating them if they don't exist, using `SQLAlchemy's` `create_all` method within the `Flask` app context.

7. **RESTful API**:
   - Follows RESTful principles, making it Easy to Integrate with other Services and Applications.
   - Endpoints are designed to handle `CRUD` (Create, Read, Update, Delete) operations for User Accounts and Book Posts.

8. **Configuration**:
   - Sets up necessary configurations for the `Flask` application, including the Secret Key for `Session Management` and Database URI.
   - Customizes the Login View and manages Sensitive Information using `Environment Variables`.

9. **Containerization**:
   - The application is containerized using `Docker`, ensuring Consistent Deployment across Different Environments.
   - `Docker` simplifies the process of Managing Dependencies and Configurations, providing an Isolated and Stable Environment for the application.

10. **Production Deployment with Gunicorn**:
      - The app is served using `Gunicorn`, which allows for handling multiple requests concurrently, improving performance and reliability in a production environment.
      - `Gunicorn` can be easily configured to work with various worker types and settings to optimize performance based on the deployment needs.

11. **Security**:
      - **Password Encryption**: Utilizes `Flask-Bcrypt` to hash and securely store user passwords.
      - **Environment Variables**: Manages sensitive information such as the secret key using environment variables to avoid hardcoding credentials.
      - **Access Control**: Protects routes to ensure that only Authenticated Users can access certain pages and perform specific actions.
      - **CSRF Protection**: Uses `Flask-WTF` to include `CSRF` (Cross-Site Request Forgery) Tokens in Forms, preventing Unauthorized Actions from being executed.

The App demonstrates a robust and comprehensive use of `Flask` and its extensions to build a scalable Web App with `User Authentication`, `Form Handling`, `File Uploads`, `RESTful API` endpoints, and `Database Operations`, all within a Containerized Environment. Emphasis on `Security` ensures that User Data is Protected through various mechanisms, making the Application Reliable and Secure.

---

## How to install this project

#### Build and run Docker container

1. **Build the Docker image:**

    ```bash
    docker build -t book-finder-web-app .
    ```

    This command builds a Docker image from your Dockerfile and tags it `-t` as `book-finder-web-app`. The `.` at the end of the command tells Docker to look for the Dockerfile in the current directory.

2. **Run the Docker container:**  

    On local machine:
    ```bash
    Generate a Secret Key:

    >>> import secrets
    >>> print(secrets.token_hex(16))
    ```

    On server:
    ```bash
    $ docker run -d -p 5001:5001 --name book-finder-web-app --restart unless-stopped -e SECRET_KEY='your_generated_secret_key' book-finder-web-app
    ```

    - `-d` runs the container in detached mode (in the background)
    - `-p 5001:5001` maps port `5001` on the host to port `5001` in the container
    - `--name book-finder-web-app` names the container
    - `--restart unless-stopped` ensures the container restarts automatically unless it is explicitly stopped
    - `book-finder-web-app` is the name of the image to run

3. **Access the running container:**

    ```bash
    $ docker ps
    $ docker exec -it <container: name || id> /bin/bash
    ```

    - `-i` -- interactive mode
    - `-t` -- TTY
---
