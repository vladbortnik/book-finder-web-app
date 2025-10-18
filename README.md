<p align="center">
  <img src="static/book-finder.jpg" alt="Student Book Exchange Platform" width="100%" />
</p>

<h1 align="center">📚 Student Book Exchange Platform</h1>

<p align="center">
  <strong>A direct marketplace where students can buy and sell textbooks to each other</strong>
</p>

<p align="center">
  <a href="http://bookfinder.vladbortnik.dev">🌐 Live Demo</a> •
  <a href="#-features">Features</a> •
  <a href="#-tech-stack">Tech Stack</a> •
  <a href="#-installation">Installation</a> •
  <a href="#-deployment">Deployment</a>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Python-3.8+-3776AB?style=for-the-badge&logo=python&logoColor=white" alt="Python" />
  <img src="https://img.shields.io/badge/Flask-2.0+-000000?style=for-the-badge&logo=flask&logoColor=white" alt="Flask" />
  <img src="https://img.shields.io/badge/Docker-Ready-2496ED?style=for-the-badge&logo=docker&logoColor=white" alt="Docker" />
  <img src="https://img.shields.io/badge/Bootstrap-4.3-7952B3?style=for-the-badge&logo=bootstrap&logoColor=white" alt="Bootstrap" />
</p>

---

## 🎯 Mission

Textbooks can be prohibitively expensive, forcing many students to opt for used ones each semester. Unfortunately, book resellers often exploit this demand by overpricing even second-hand books.

**Our solution:**
- 🤝 Direct student-to-student marketplace
- 💰 Eliminate expensive third-party resellers
- ⚖️ Ensure fair prices for everyone
- 🎓 Built by a Brooklyn College alumnus for students

---

## ✨ Features

### 🔐 **User Authentication & Security**
- Secure user registration and login system
- Password encryption using Flask-Bcrypt
- Session management with Flask-Login
- Protected routes and access control
- CSRF protection on all forms

### 📖 **Book Marketplace**
- Create, read, update, and delete book posts (full CRUD)
- Upload book cover images
- Department-based categorization (ANTH, BIO, CISC, ENG, MATH)
- Real-time filtering by department
- View seller contact information

### 👤 **User Account Management**
- Personal account dashboard
- View and manage your book listings
- Update or delete your posts
- Contact information displayed to potential buyers

### 🎨 **Responsive Design**
- Mobile-first Bootstrap 4 implementation
- Clean, intuitive user interface
- Optimized for all screen sizes
- Modern, student-friendly aesthetic

### 🚀 **Performance & Scalability**
- RESTful API architecture
- Efficient database queries with SQLAlchemy ORM
- Production-ready deployment with Gunicorn
- Containerized with Docker for consistent environments

---

## 🛠 Tech Stack

| Category | Technology | Purpose |
|----------|-----------|---------|
| **Backend** | Flask 2.0+ | Web application framework |
| **Database** | SQLAlchemy | ORM for database operations |
| | SQLite/PostgreSQL | Data persistence |
| **Authentication** | Flask-Login | User session management |
| | Flask-Bcrypt | Password hashing |
| **Forms** | Flask-WTF | Form handling and validation |
| | WTForms | Form field definitions |
| **Frontend** | Bootstrap 4.3 | Responsive UI framework |
| | JavaScript ES6 | Client-side interactivity |
| **Deployment** | Docker | Containerization |
| | Gunicorn | WSGI HTTP server |
| | Nginx | Reverse proxy (production) |
| **Security** | CSRF Tokens | Cross-site request forgery protection |
| | Environment Variables | Secure configuration management |

---

## 📁 Project Structure

```
book-finder-web-app/
├── app.py                 # Main application file
├── Dockerfile             # Docker container configuration
├── requirements.txt       # Python dependencies
├── static/                # Static assets
│   ├── main.css          # Custom styles
│   ├── favicon.ico       # Site icon
│   └── [uploaded-images] # User-uploaded book images
├── templates/             # HTML templates
│   ├── layout.html       # Base template with SEO optimization
│   ├── index.html        # Home page with book listings
│   ├── about.html        # About page
│   ├── signUp.html       # User registration
│   ├── logIn.html        # User login
│   ├── account.html      # User dashboard
│   ├── createPost.html   # Book post form
│   └── post.html         # Individual book details
└── instance/
    └── site.db           # SQLite database (development)
```

---

## 🚀 Installation

### Prerequisites
- Python 3.8 or higher
- Docker (optional, for containerized deployment)

### Local Development

1. **Clone the repository**
   ```bash
   git clone https://github.com/vladbortnik/book-finder.git
   cd book-finder-web-app
   ```

2. **Create a virtual environment**
   ```bash
   python -m venv venv
   source venv/bin/activate  # On Windows: venv\Scripts\activate
   ```

3. **Install dependencies**
   ```bash
   pip install -r requirements.txt
   ```

4. **Generate a secret key**
   ```python
   python
   >>> import secrets
   >>> print(secrets.token_hex(16))
   >>> exit()
   ```

5. **Set environment variable and run**
   ```bash
   export SECRET_KEY='your_generated_secret_key'
   flask run
   ```

6. **Access the application**
   ```
   Open your browser to: http://127.0.0.1:5000
   ```

---

## 🐳 Docker Deployment

### Build the Docker Image
```bash
docker build -t book-finder-web-app .
```

### Run the Container

**Development:**
```bash
docker run -d -p 5001:5001 \
  --name book-finder-web-app \
  -e SECRET_KEY='your_generated_secret_key' \
  book-finder-web-app
```

**Production:**
```bash
docker run -d -p 5001:5001 \
  --name book-finder-web-app \
  --restart unless-stopped \
  -e SECRET_KEY='your_generated_secret_key' \
  book-finder-web-app
```

### Access the Running Container
```bash
# View running containers
docker ps

# Access container shell
docker exec -it book-finder-web-app /bin/bash
```

### Container Management
```bash
# Stop the container
docker stop book-finder-web-app

# Start the container
docker start book-finder-web-app

# View logs
docker logs book-finder-web-app

# Remove the container
docker rm book-finder-web-app
```

---

## 🔒 Security Features

| Feature | Implementation |
|---------|---------------|
| **Password Security** | Bcrypt hashing algorithm with salt |
| **Session Management** | Secure cookie-based sessions |
| **CSRF Protection** | Token-based form validation |
| **Environment Variables** | Sensitive data stored outside codebase |
| **Route Protection** | Login required decorators |
| **Input Validation** | WTForms validators on all inputs |
| **SQL Injection Prevention** | SQLAlchemy ORM parameterized queries |

---

## 🌐 SEO Optimization

The platform includes comprehensive SEO features:
- ✅ Dynamic meta descriptions and keywords
- ✅ Open Graph tags for social media sharing
- ✅ Twitter Card integration
- ✅ Structured data (JSON-LD) for search engines
- ✅ Canonical URLs to prevent duplicate content
- ✅ XML sitemap generation (`/sitemap.xml`)
- ✅ Robots.txt configuration (`/robots.txt`)
- ✅ Semantic HTML5 markup

---

## 📊 Database Schema

### User Model
| Field | Type | Description |
|-------|------|-------------|
| id | Integer | Primary key |
| firstName | String(30) | User's first name |
| lastName | String(30) | User's last name |
| username | String(20) | Unique username |
| email | String(120) | Unique email address |
| phone | String(20) | Contact phone number |
| password | String(60) | Bcrypt hashed password |

### Post Model
| Field | Type | Description |
|-------|------|-------------|
| id | Integer | Primary key |
| title | String(100) | Book title |
| department | String(4) | Academic department |
| datePosted | DateTime | Post creation timestamp |
| imageFile | String(20) | Uploaded image filename |
| content | Text | Book details (author, edition) |
| user_id | Integer | Foreign key to User |

---

## 🎓 Use Cases

1. **Student Sellers**
   - Post textbooks after completing courses
   - Set own prices based on book condition
   - Manage multiple listings from account dashboard

2. **Student Buyers**
   - Browse available textbooks by department
   - View book details, condition, and seller contact
   - Connect directly with sellers for transactions

3. **Department Coordinators**
   - Monitor textbook availability for courses
   - Identify commonly needed textbooks

---

## 🔄 API Endpoints

| Method | Endpoint | Description | Auth Required |
|--------|----------|-------------|---------------|
| GET | `/` | View all book posts | No |
| GET | `/about` | About page | No |
| GET/POST | `/signUp` | User registration | No |
| GET/POST | `/logIn` | User login | No |
| GET | `/logOut` | User logout | Yes |
| GET | `/account` | User dashboard | Yes |
| GET/POST | `/post/new` | Create new post | Yes |
| GET | `/post/<id>` | View post details | No |
| GET/POST | `/post/<id>/update` | Update post | Yes (Owner) |
| POST | `/post/<id>/delete` | Delete post | Yes (Owner) |
| GET | `/robots.txt` | Robots file | No |
| GET | `/sitemap.xml` | XML sitemap | No |

---

## 🚦 Future Enhancements

- [ ] Search functionality across all listings
- [ ] Advanced filtering (price range, condition, etc.)
- [ ] User ratings and reviews system
- [ ] Direct messaging between buyers and sellers
- [ ] Email notifications for new listings
- [ ] Price history and market analytics
- [ ] Mobile app (React Native)
- [ ] Payment integration
- [ ] Book condition assessment tool
- [ ] Multi-campus support

---

## 📜 License

This project is part of a portfolio demonstrating full-stack web development capabilities.

---

## 👨‍💻 About the Developer

🌟 Built with a passion for clean code, robust architecture, and scalable solutions

Software Engineer | Frontend (React 19) → Backend (Flask, PostgreSQL) → Infrastructure (Docker, Nginx, Cloud)

**Connect with me:**

[![Portfolio](https://img.shields.io/badge/Portfolio-vladbortnik.dev-0EA5E9?style=for-the-badge&logo=google-chrome&logoColor=white)](https://vladbortnik.dev)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/vladbortnik)
[![Twitter](https://img.shields.io/badge/Twitter-@vladbortnik__dev-1DA1F2?style=for-the-badge&logo=x&logoColor=white)](https://x.com/vladbortnik_dev)
[![GitHub](https://img.shields.io/badge/GitHub-Follow-181717?style=for-the-badge&logo=github&logoColor=white)](https://github.com/vladbortnik)
[![Contact](https://img.shields.io/badge/Contact_Me-Get_In_Touch-00C853?style=for-the-badge&logo=gmail&logoColor=white)](https://vladbortnik.dev/contact.html)

---

<p align="center">
  <sub>Built with ❤️ by <a href="https://vladbortnik.dev">Vlad Bortnik</a> • New York, NY 🗽</sub>
</p>
