# Funnel Analyzer

Funnel Analyzer is a Java-based web application designed to manage and analyze user activity across an e-commerce sales funnel. It provides a web interface for entering funnel-related data and viewing information through a dashboard.

The application follows the **Model-View-Controller (MVC)** architecture, using Java Servlets and JSP for request handling and presentation, with MySQL for database management.

## Technologies Used

| Technology | Purpose |
|---|---|
| Java | Core application logic |
| Java Servlets | Request handling and application flow |
| JSP | Dynamic web page rendering |
| HTML, CSS, JavaScript | Frontend development |
| MySQL | Database management |
| Apache Tomcat | Web application server |
| Eclipse IDE | Development environment |

## Key Components

- **Data Management:** Provides an interface for entering funnel-related data.
- **Dashboard:** Displays application information through a JSP-based dashboard.
- **Database Connectivity:** Uses MySQL for storing and retrieving application data.
- **Request Handling:** Uses Java Servlets to process incoming requests and coordinate application operations.

## MVC Architecture

The project follows the Model-View-Controller design pattern, separating the application into different layers:

- **Model:** Represents application data and business entities.
- **View:** JSP and HTML pages responsible for displaying information and providing the user interface.
- **Controller:** Java Servlets handle incoming HTTP requests and coordinate interactions between the model and view.
- **DAO (Data Access Object):** Manages database operations and communication with MySQL.
- **Service:** Organizes application-level logic and operations.

This structure promotes separation of concerns and makes the application easier to maintain and organize.

## Project Structure

```text
Funnel-Analyzer/
│
├── src/
│   └── main/
│       ├── java/
│       │   ├── controller/
│       │   ├── DAO/
│       │   ├── model/
│       │   ├── service/
│       │   └── util/
│       │
│       └── webapp/
│           ├── META-INF/
│           ├── WEB-INF/
│           ├── addData.html
│           ├── dashboard.jsp
│           └── index.html
│
└── README.md
```

## Application Pages

- **index.html:** Main entry page of the application.
- **addData.html:** Interface for adding funnel-related data.
- **dashboard.jsp:** Dashboard for displaying application information.

## Database

The application uses **MySQL** for database management and the MySQL Connector/J library for Java-to-MySQL connectivity.

## How to Run

1. Import the project into Eclipse IDE.
2. Configure Apache Tomcat as the application server.
3. Set up the MySQL database and configure the database connection.
4. Add the required MySQL Connector/J dependency.
5. Deploy the project on Tomcat and start the server.

## Development Environment

- **IDE:** Eclipse IDE
- **Server:** Apache Tomcat
- **Database:** MySQL
- **Architecture:** MVC

