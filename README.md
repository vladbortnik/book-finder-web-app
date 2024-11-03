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
   - Utilizes **`Flask-Login`** for handling *`User Authentication`*, *`Session Management`*, and *`Protecting Routes`* to ensure only Authenticated Users can access certain pages.
   - Users can securely Sign up & Log in, protected by *`Password Hashing`* with **`Flask-Bcrypt`**. 

2. **Form Handling**:
   - Uses **`Flask-WTF`** to create forms for User Sign-up, Log in, and Post creation.
   - Includes **`WTForms Validators`** to ensure *`Data Integrity`*.

3. **Database Models**:
   - **`SQLAlchemy`** is used as the ORM to define User and Post models, representing the application's Data Structure.
   - The *`User Model`* stores user information, while the *`Post Model`* stores information about book posts and associated image files.

4. **File Uploads**:
   - Implements **`File Handling`** to allow users to upload images for their book posts.
   - Generates a *`Unique Filename`* for each upload (to avoid conflicts) and *`Stores Files`* on the Server.

5. **Web Pages and Routing**:
   - Defines *`Routes`* for various pages, like *Home*, *About*, *Account*, etc.
   - Uses **`Jinja2`** Template Engine to render HTML templates, dynamically passing data from the Server to templates.
   - *`Responsive Design`* implemented with **`Bootstrap 4`** makes UI responsive and user-friendly across various devices and screen sizes.

6. **Database**:
   - Utilizes **`SQLite`** for robust data storage.
   - Initializes *DB* and creates *Tables* using **`SQLAlchemy`** *`create_all`* method within the *Flask App Context*.

7. **RESTful API**:
   - Follows **`RESTful Principles`**, making it easy to Integrate with other Services and Applications.
   - *`Endpoints`* are designed to handle **`CRUD`** (*Create, Read, Update, Delete*) operations for *User Accounts* and *Book Posts*.

8. **Configuration**:
   - Sets up necessary configurations for the *Flask App*, including the *Secret Key* for **`Session Management`** and *Database URI*.
   - Customizes the *Login View* and manages *Sensitive Information* using **`Environment Variables`**.

9. **Containerization**:
   - **`Docker`** simplifies the process of *`Managing Dependencies`* and *`Configuration`*, providing an *`Isolated and Stable Environment`* for the application.
   - The application is containerized using **`Dockerfile`**, ensuring *`Consistent Deployment`* across *Different Environments*.

10. **Production Deployment with Gunicorn**:
      - The app is served using **`Gunicorn`**, which allows multiple *`Requests Concurrency`*, improving *Performance* and *Reliability* in a *`Production Environment`*.
      - **`Gunicorn`** can be easily configured to work with various worker types and settings to *`Optimize Performance`* based on the deployment needs.

11. **Security**:
      - **Password Encryption**: Utilizes **`Flask-Bcrypt`** to *`Hash`* and *`Securely Store`* user *Passwords*.
      - **Environment Variables**: Manages *Sensitive Information* (such as the secret key) using **`Environment Variables`** to *Avoid Hardcoding* credentials.
      - **Access Control**: Protects routes with **`Flask-Login`** to ensure only *`Authenticated Users`* can access certain pages and perform specific actions.
      - **CSRF Protection**: Uses **`Flask-WTF`** to include *`CSRF`* (*Cross-Site Request Forgery*) *Tokens* in forms, *`Preventing Unauthorized Actions`* from being executed.

The App demonstrates a robust and comprehensive use of *`Flask`* and its *extensions* to build a scalable Web App with **`User Authentication`**, **`Form Handling`**, **`File Uploads`**, **`RESTful API`** endpoints, and **`Database Operations`**, all within a **`Containerized Environment`**. Emphasis on *`Security`* ensures that *User Data is Protected* through various mechanisms, making the *Application* *`Reliable and Secure`*.

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
