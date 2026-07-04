# 04 · Conectar o WhatsApp

Guia para conectar seu número de WhatsApp à Evolution API via QR Code.

---

## Passo 1 — Acessar o Manager

Abrir no navegador:
```
http://localhost:8080/manager
```

Fazer login:
- **Server URL:** `http://localhost:8080`
- **API Key:** (a senha definida no `.env`)

---

## Passo 2 — Criar uma instância

1. Clicar em **New Instance**
2. Preencher:
   - **Nome:** `minha-instancia` (sem espaços ou caracteres especiais)
   - **Integration:** `WHATSAPP-BAILEYS`
3. Clicar em **Create**

---

## Passo 3 — Escanear o QR Code

1. Na lista de instâncias, clicar em **Get QR Code**
2. Abrir o WhatsApp no celular
3. Tocar em **⋮ (três pontos)** → **Aparelhos conectados** → **Conectar aparelho**
4. Escanear o QR Code exibido na tela

> ⚠️ O QR Code expira em **~30 segundos**. Se expirar, clicar em **Get QR Code** novamente.

---

## Passo 4 — Confirmar conexão

Aguardar o status mudar para:
```
Connected ✅
```

Quando conectado, o número está pronto para enviar e receber mensagens via N8N.

---

## Configurar o Webhook na instância

Para que as mensagens recebidas sejam enviadas ao N8N:

1. Na instância → **Webhooks**
2. Em **Global Webhook URL**, colar:
   ```
   http://n8n:5678/webhook/SEU-ID-DO-WEBHOOK
   ```
3. Em **Events**, selecionar `message`
4. Salvar

> O ID do webhook é gerado pelo N8N — copiar do nó Webhook → Production URL e trocar `localhost` por `n8n`.

---

## Expressões úteis no N8N

Quando uma mensagem chega via Evolution API, esses são os campos do payload:

```javascript
$json.body.sender                           // número do remetente
$json.body.data.message.conversation        // texto da mensagem
$json.body.data.key.remoteJid              // chat ID (para responder)
$json.body.instance                         // nome da instância
$json.body.data.pushName                    // nome do contato
$json.body.data.key.id                      // ID único da mensagem
```

---

## Testar o envio

Após ativar o workflow no N8N (toggle **Inactive → Active**), mande uma mensagem para o número conectado e verifique o painel **Executions** no N8N.

---

## Avisos importantes

> ⚠️ O WhatsApp não permite oficialmente bots ou integrações não homologadas. Use para **estudo e automações internas**.

> ⚠️ O número conectado não pode estar logado no WhatsApp Web simultaneamente.

> ⚠️ Ao reiniciar o container, pode ser necessário reconectar via QR Code.

---

[← Configurar N8N](03-configurar-n8n.md) | [Próximo: Solução de Problemas →](05-solucao-problemas.md)
