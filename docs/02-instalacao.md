# 02 · Instalação

Guia completo para instalar a stack N8N + Evolution API com Docker Compose.

---

## 📁 Estrutura de arquivos

Após a instalação você terá:

```
C:\docker\evolution\
├── criar_arquivos.ps1    ← script de criação dos arquivos
├── Dockerfile            ← instruções de build da Evolution API
├── .env                  ← variáveis de ambiente (com sua senha)
└── docker-compose.yml    ← orquestração dos 4 serviços
```

---

## Passo 1 — Criar a pasta do projeto

Abrir o **PowerShell** e executar:

```powershell
mkdir C:\docker\evolution
```

---

## Passo 2 — Baixar e executar o script

1. Baixar o arquivo [`criar_arquivos.ps1`](../criar_arquivos.ps1) deste repositório
2. Mover para `C:\docker\evolution\`
3. Executar no PowerShell:

```powershell
cd C:\docker\evolution
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\criar_arquivos.ps1
```

Quando perguntar sobre a política de execução, digitar `A` e Enter.

**Resultado esperado:**
```
Dockerfile criado com sucesso
.env criado com sucesso (sem BOM)
docker-compose.yml criado com sucesso
Todos os arquivos criados!
Proximo passo: docker compose build --no-cache
```

---

## Passo 3 — Configurar a senha no .env

```powershell
notepad C:\docker\evolution\.env
```

Localizar a linha:
```
AUTHENTICATION_API_KEY=sua-chave-secreta-aqui
```

Trocar `sua-chave-secreta-aqui` por uma **senha forte** e anotar.

> ⚠️ Essa senha será usada em 3 lugares: `.env`, Manager da Evolution e credencial do N8N.

Salvar com `Ctrl+S` e fechar.

---

## Passo 4 — Build da Evolution API

> ⚠️ Demora entre 5 e 10 minutos. Requer internet estável.

```powershell
docker compose build --no-cache
```

---

## Passo 5 — Subir os containers

```powershell
docker compose up -d
```

**Resultado esperado:**
```
Container postgres        Started
Container redis           Started
Container n8n             Started
Container evolution-api   Started
```

---

## Passo 6 — Verificar funcionamento

Aguardar 30 segundos e rodar:

```powershell
docker logs evolution-api --tail 10
```

**Resultado esperado:**
```
[Evolution API]  HTTP - ON: 8080
```

---

## Passo 7 — Confirmar no navegador

| Serviço | URL |
|---|---|
| N8N | http://localhost:5678 |
| Evolution Manager | http://localhost:8080/manager |

Na primeira vez que acessar o N8N, criar conta owner (nome, email, senha).

---

## Comandos úteis

```powershell
# Iniciar tudo
docker compose up -d

# Parar tudo
docker compose down

# Ver logs da Evolution
docker logs evolution-api --tail 30

# Ver logs do N8N
docker logs n8n --tail 30

# Reiniciar Evolution
docker compose restart evolution-api

# Listar containers
docker ps
```

---

## Versões confirmadas

| Serviço | Versão |
|---|---|
| Evolution API | v2.3.7 |
| N8N | latest |
| PostgreSQL | 15 |
| Redis | 7 |
| Node.js (base) | 20-alpine |

---

[← Pré-requisitos](01-pre-requisitos.md) | [Próximo: Configurar N8N →](03-configurar-n8n.md)
