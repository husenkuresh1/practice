# Docker Exercise

## Introduction

This is netflix clone.

I added dockerfile and docker-compose.yml file in it for it's containerization.

## Prerequisites

Ensure that you have the following installed on your machine:

- [Docker](https://www.docker.com/)

## How to run in container

1. Clone the repository:

   ```bash
   git clone https://github.com/josuapsianturi/velflix.git
   cd velflix
    ```

2.  Set you .env file for refrence .env.example file is provided. You need to copy or rename it with .env and set your own parameters in it.

###  For Example

```bash
DB_PASSWORD= your_database_password
DB_DATABASE= your_database_name
```

3. Create account and get an API key themoviedb [ here](https://www.themoviedb.org/settings/api). Make sure to copy `API Read Access Token (v4 auth)`.
    - paste `TMDB_TOKEN=(your API key)` 
    > Make sure to follow your database username and password
    
4. Now your project repo is ready to run. Just type following command in your terminal or command prompt to start containers.

```bash
docker compose up
```

5. After container starts go to browser and type following in url 

```bash
localhost:8080
```

<!-- ## THANK YOU
Big thank you to [Bhautik Bhai](https://github.com/BhautikChudasama) for their help and support for making this exercise possible -->