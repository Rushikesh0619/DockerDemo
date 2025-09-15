# Booking – React + Spring Boot + Postgres (Docker)

Serve a React UI via Nginx, proxy API calls to Spring Boot, and use Postgres with Docker Compose.

## Stack
- Frontend: React (`dist/`, served by Nginx)
- Backend: Spring Boot (`booking-service.jar`)
- Database: Postgres 16
- Infra: Docker, Docker Compose, Nginx

## Repository Structure
```
.
├─ dist/                       # React build output
├─ booking-service.jar         # Spring Boot app
├─ docker/
│  ├─ nginx.conf               # Nginx serves UI + proxies /user/* → api
│  ├─ frontend.Dockerfile      # Nginx runtime
│  └─ backend.Dockerfile       # JRE runtime
├─ docker-compose.yml
└─ .env.example
```

## Prerequisites
- Docker Engine  
- Docker Compose v2

## Setup
1. Copy `.env.example` → `.env` and adjust values:
   ```env
   DB_NAME=booking
   DB_USER=booking_user
   DB_PASSWORD=booking_pass_123
   TZ=Asia/Kolkata

   # Spring overrides (optional)
   DDL_AUTO=update
   SHOW_SQL=false
   FORMAT_SQL=false
   OPEN_IN_VIEW=false
   SQL_INIT_MODE=never
   ```
2. Ensure the frontend calls the API **relative to same origin** (e.g., `fetch("/user/...")`).
3. Place your built artifacts in the repo root:
   - `dist/` (React build)
   - `booking-service.jar` (Spring Boot)

## Run
```bash
docker compose --env-file .env build
docker compose --env-file .env up -d
```

## URLs
- UI: `http://localhost/`
- API (direct): `http://localhost:8080/user/getAllUsers`

## API Endpoints
- `POST /user/saveUser`
- `POST /user/saveAll`
- `GET  /user/getUser/{userName}`
- `GET  /user/getAllUsers?page=&size=&sortBy=&ascending=`

**Example**
```bash
curl -X POST http://localhost/user/saveUser   -H "Content-Type: application/json"   -d '{"userName":"jdoe","firstName":"John","lastName":"Doe","email":"john@example.com"}'
```

## Notes
- Inside Docker, the backend connects to Postgres at `jdbc:postgresql://db:5432/${DB_NAME}`.
- Nginx proxies `/user/*` → `api:8080/user/*`.
