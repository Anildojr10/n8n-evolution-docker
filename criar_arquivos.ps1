# ================================================
# SCRIPT POWERSHELL — Criar arquivos do projeto
# Salvar como: C:\docker\evolution\criar_arquivos.ps1
# Executar com: .\criar_arquivos.ps1
# ================================================

# Garante que está na pasta correta
Set-Location C:\docker\evolution

# ── DOCKERFILE ──
$dockerfile = @'
FROM node:20-alpine

RUN apk add --no-cache git bash openssl ffmpeg tzdata

ENV TZ=America/Sao_Paulo

WORKDIR /evolution

RUN git clone https://github.com/evolution-foundation/evolution-api.git . && \
    npm install && \
    npx prisma generate --schema ./prisma/postgresql-schema.prisma && \
    npm run build

EXPOSE 8080

ENTRYPOINT ["/bin/bash", "-c", ". ./Docker/scripts/deploy_database.sh && npm run start:prod"]
'@
[System.IO.File]::WriteAllText("C:\docker\evolution\Dockerfile", $dockerfile, [System.Text.Encoding]::UTF8)
Write-Host "Dockerfile criado com sucesso" -ForegroundColor Green

# ── .ENV ──
# ATENÇÃO: Troque "sua-chave-secreta-aqui" pela sua senha
$env_content = @'
SERVER_URL=http://localhost:8080
AUTHENTICATION_TYPE=apikey
AUTHENTICATION_API_KEY=sua-chave-secreta-aqui
AUTHENTICATION_EXPOSE_IN_FETCH_INSTANCES=true
DATABASE_ENABLED=true
DATABASE_PROVIDER=postgresql
DATABASE_CONNECTION_URI=postgresql://evolution:evolution123@postgres:5432/evolution
DATABASE_SAVE_DATA_INSTANCE=true
DATABASE_SAVE_DATA_NEW_MESSAGE=true
DATABASE_SAVE_MESSAGE_UPDATE=true
DATABASE_SAVE_DATA_CONTACTS=true
DATABASE_SAVE_DATA_CHATS=true
CACHE_REDIS_ENABLED=false
CACHE_LOCAL_ENABLED=true
QRCODE_LIMIT=30
LOG_LEVEL=ERROR
'@
[System.IO.File]::WriteAllText("C:\docker\evolution\.env", $env_content, [System.Text.UTF8Encoding]::new($false))
Write-Host ".env criado com sucesso (sem BOM)" -ForegroundColor Green

# ── DOCKER-COMPOSE.YML ──
$compose = @'
version: '3.8'

services:
  postgres:
    image: postgres:15
    container_name: postgres
    restart: always
    environment:
      - POSTGRES_USER=evolution
      - POSTGRES_PASSWORD=evolution123
      - POSTGRES_DB=evolution
    volumes:
      - postgres_data:/var/lib/postgresql/data
    networks:
      - evolution-net

  redis:
    image: redis:7
    container_name: redis
    restart: always
    networks:
      - evolution-net

  n8n:
    image: n8nio/n8n
    container_name: n8n
    restart: always
    ports:
      - "5678:5678"
    environment:
      - N8N_HOST=localhost
      - N8N_PORT=5678
      - N8N_PROTOCOL=http
      - WEBHOOK_URL=http://localhost:5678/
    volumes:
      - n8n_data:/home/node/.n8n
    networks:
      - evolution-net

  evolution-api:
    build: .
    container_name: evolution-api
    restart: always
    ports:
      - "8080:8080"
    depends_on:
      - postgres
      - redis
    volumes:
      - evolution_data:/evolution/instances
      - ./.env:/evolution/.env
    networks:
      - evolution-net

networks:
  evolution-net:
    driver: bridge

volumes:
  n8n_data:
  evolution_data:
  postgres_data:
'@
[System.IO.File]::WriteAllText("C:\docker\evolution\docker-compose.yml", $compose, [System.Text.Encoding]::UTF8)
Write-Host "docker-compose.yml criado com sucesso" -ForegroundColor Green

Write-Host ""
Write-Host "Todos os arquivos criados!" -ForegroundColor Cyan
Write-Host "Proximo passo: docker compose build --no-cache" -ForegroundColor Yellow
