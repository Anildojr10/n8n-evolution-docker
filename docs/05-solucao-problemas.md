# 05 · Solução de Problemas

Erros comuns e como resolver.

---

## Docker

### Docker não abre / fica em loop "Starting"

**Causa:** WSL2 não está instalado ou configurado.

**Solução:**
```powershell
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
```
Reiniciar o computador. Baixar e instalar o kernel WSL2:
```
https://aka.ms/wsl2kernel
```
Instalar o Ubuntu:
```
C:\Windows\System32\wsl.exe --install -d Ubuntu
```

---

### `docker` não é reconhecido como comando

**Causa:** Docker Desktop não está rodando ou terminal aberto antes do Docker iniciar.

**Solução:** Abrir o Docker Desktop, aguardar o ícone ficar verde, fechar e abrir um novo terminal.

---

### Erro "not a valid identifier" nos logs da Evolution

**Causa:** Arquivo `.env` criado com BOM (caractere invisível no início do arquivo). Ocorre quando se usa `Out-File -Encoding utf8` no PowerShell.

**Solução:** Recriar o `.env` usando o script `criar_arquivos.ps1` — ele usa `utf8NoBOM` automaticamente.

```powershell
.\criar_arquivos.ps1
docker compose restart evolution-api
```

---

### Build falha no meio

**Causa:** Internet caiu durante o clone do GitHub.

**Solução:**
```powershell
docker compose build --no-cache
```

---

## Evolution API

### QR Code não aparece / erro 500

**Causa:** Instância não configurada corretamente ou banco não inicializado.

**Solução:**
```powershell
docker compose restart evolution-api
```
Aguardar 30 segundos e tentar novamente.

---

### Evolution não recebe mensagens do WhatsApp

**Causa:** Webhook URL incorreta no Manager.

**Solução:** Verificar se a URL usa `n8n` e não `localhost`:
```
✅ http://n8n:5678/webhook/SEU-ID
❌ http://localhost:5678/webhook/SEU-ID
```

---

### Erro de autenticação no node Evolution (N8N)

**Causa:** API Key na credencial do N8N diferente da definida no `.env`.

**Solução:** Verificar se as duas senhas são iguais — `.env` e credencial N8N → Server URL e API Key.

---

## N8N

### Bot não responde às mensagens

**Causa:** Workflow inativo.

**Solução:** Ativar o toggle **Inactive → Active** no canto superior direito do workflow.

---

### Erro "Paired item data unavailable"

**Causa:** Code node retorna menos itens do que recebeu, quebrando o rastreamento de pares do N8N.

**Solução:** Incluir `instancia` e `remoteJid` no retorno do Code node:

```javascript
return [{
  json: {
    // ... outros campos
    instancia: $('Edit Fields').item.json.instancia,
    remoteJid: $('Edit Fields').item.json.remoteJid
  }
}];
```

No nó de envio, usar referência direta:
```
instanceName: {{ $('Consolidar Dados').item.json.instancia }}
remoteJid:    {{ $('Consolidar Dados').item.json.remoteJid }}
```

---

### Token limit Groq (erro 429)

**Causa:** Limite de 12.000 tokens por minuto no plano gratuito atingido.

**Solução:**
- Reduzir `contextWindowLength` para 5 no Memory node
- Desativar `include_raw_content` no Tavily (`false`)
- Usar `llama-3.1-8b-instant` no orquestrador (limite maior)

---

### Rate limit Gemini (erro 429)

**Causa:** 20 requisições por dia no plano gratuito esgotadas.

**Solução:** Usar Groq em todos os agentes. O Gemini 2.5 Flash tem limite maior — verificar plano em [console.cloud.google.com](https://console.cloud.google.com).

---

## Rede Docker

### Containers não se comunicam

**Causa:** Usando `localhost` em vez do nome do serviço.

**Regra:**

| De → Para | URL correta |
|---|---|
| N8N → Evolution | `http://evolution-api:8080` |
| Evolution → N8N | `http://n8n:5678` |
| Navegador → qualquer | `http://localhost:PORTA` |

---

### Nome da rede diferente do esperado

O Docker Compose cria a rede com o prefixo do nome da pasta:

```
Pasta: C:\docker\evolution\
Rede criada: evolution_evolution-net
```

Isso é normal e não afeta o funcionamento.

---

[← Conectar WhatsApp](04-conectar-whatsapp.md) | [← Voltar ao README](../README.md)
