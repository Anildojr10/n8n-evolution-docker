# 🤖 N8N + Evolution API + Docker

> Material didático — Digital College · Módulo 03 · Automação com IA

Stack completa para integrar WhatsApp com automações inteligentes usando N8N, Evolution API e Docker Compose.

---

## 📦 O que está incluído

| Arquivo/Pasta | Descrição |
|---|---|
| `criar_arquivos.ps1` | Script PowerShell que cria todos os arquivos necessários |
| `docker-compose.yml` | Referência da stack completa |
| `.env.example` | Modelo de variáveis de ambiente |
| `docs/` | Guias passo a passo |
| `fluxos/` | JSONs dos fluxos N8N prontos para importar |

---

## 🚀 Início rápido

### Pré-requisitos
- Windows 10/11 64-bit
- [Docker Desktop](https://www.docker.com/products/docker-desktop/) instalado e rodando
- WSL2 instalado (veja [docs/01-pre-requisitos.md](docs/01-pre-requisitos.md))

### Instalação em 3 passos

**1. Criar a pasta e baixar o script:**
```powershell
mkdir C:\docker\evolution
```
Baixar o arquivo `criar_arquivos.ps1` e mover para `C:\docker\evolution\`

**2. Executar o script:**
```powershell
cd C:\docker\evolution
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\criar_arquivos.ps1
```

**3. Editar a senha e subir os containers:**
```powershell
notepad .env
docker compose build --no-cache
docker compose up -d
```

> Guia completo em [docs/02-instalacao.md](docs/02-instalacao.md)

---

## 🐳 Serviços da stack

| Container | Porta | Descrição |
|---|---|---|
| `n8n` | 5678 | Automação visual |
| `evolution-api` | 8080 | API do WhatsApp |
| `postgres` | 5432 | Banco de dados |
| `redis` | 6379 | Cache |

Todos os containers compartilham a rede `evolution-net` e se comunicam pelo nome do serviço.

---

## 🔗 Acessos após instalação

| Serviço | URL |
|---|---|
| N8N | http://localhost:5678 |
| Evolution Manager | http://localhost:8080/manager |
| Evolution Swagger | http://localhost:8080/docs |

---

## 📋 Fluxos disponíveis

| Fluxo | Descrição |
|---|---|
| `fluxo01_agente_whatsapp.json` | AI Agent no WhatsApp com memória de sessão |
| `fluxo02_agente_sheets_whatsapp.json` | Agente que responde perguntas sobre Google Sheets |
| `fluxo03_agente_postgres_whatsapp.json` | Agente com PostgreSQL como ferramenta |

---

## 📚 Documentação

1. [Pré-requisitos](docs/01-pre-requisitos.md)
2. [Instalação](docs/02-instalacao.md)
3. [Configurar o N8N](docs/03-configurar-n8n.md)
4. [Conectar o WhatsApp](docs/04-conectar-whatsapp.md)
5. [Solução de Problemas](docs/05-solucao-problemas.md)

---

## ⚠️ Aviso importante

O WhatsApp não permite oficialmente bots ou clientes não homologados. A Evolution API é ideal para **estudo e automações internas**. Para uso comercial em escala, utilize a [Meta Business API](https://business.whatsapp.com/).

---

## 🏫 Digital College

**Módulo 03 · Automação com IA · N8N na Prática**

[digitalcollege.com.br](https://digitalcollege.com.br) | [@digitalcollegebr](https://instagram.com/digitalcollegebr)
