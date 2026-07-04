# 03 · Configurar o N8N

Após subir os containers, configure o N8N para integrar com a Evolution API.

---

## Passo 1 — Instalar o node da comunidade

1. Acessar http://localhost:5678
2. Menu lateral → **Settings** → **Community Nodes** → **Install**
3. Digitar o nome do pacote:

```
n8n-nodes-evolution-api
```

4. Marcar o checkbox de confirmação → **Install**
5. Aguardar o reinício automático do N8N

**Resultado esperado:**
```
n8n-nodes-evolution-api  v2025.x.x
```

---

## Passo 2 — Criar a credencial Evolution

1. Menu lateral → **Credentials** → **Add Credential**
2. Pesquisar **Evolution API** → selecionar
3. Preencher:

| Campo | Valor |
|---|---|
| Nome | Evolution account |
| Server URL | `http://evolution-api:8080` |
| API Key | (a senha que você definiu no .env) |

4. Clicar em **Save**

> ⚠️ Usar `evolution-api` — **não** `localhost`. Os containers se comunicam pelo nome do serviço dentro da rede Docker.

---

## Passo 3 — Configurar a URL do Webhook

A Evolution API precisa saber onde enviar as mensagens recebidas.

### Obter a URL de produção

1. Criar ou abrir um workflow no N8N
2. Adicionar o nó **Webhook**
3. Copiar a **Production URL** — algo como:
   ```
   http://localhost:5678/webhook/SEU-ID-AQUI
   ```
4. Trocar `localhost` por `n8n`:
   ```
   http://n8n:5678/webhook/SEU-ID-AQUI
   ```

### Configurar no Manager da Evolution

1. Acessar http://localhost:8080/manager
2. Login com a API Key definida no `.env`
3. Selecionar a instância → **Webhooks**
4. Colar a URL com `n8n` no lugar de `localhost`
5. Salvar

> ⚠️ Usar `n8n` — **não** `localhost`. A Evolution está dentro do Docker e não enxerga o `localhost` da sua máquina.

---

## Comunicação entre containers

| De → Para | URL a usar |
|---|---|
| N8N → Evolution API | `http://evolution-api:8080` |
| Evolution → N8N | `http://n8n:5678` |
| Navegador → N8N | `http://localhost:5678` |
| Navegador → Evolution | `http://localhost:8080` |

---

## Importar os fluxos

1. No N8N, clicar em **+** para criar workflow
2. Menu → **Import from file**
3. Selecionar o JSON desejado da pasta `fluxos/`
4. Configurar a planilha/credencial manualmente após importar

---

[← Instalação](02-instalacao.md) | [Próximo: Conectar WhatsApp →](04-conectar-whatsapp.md)
