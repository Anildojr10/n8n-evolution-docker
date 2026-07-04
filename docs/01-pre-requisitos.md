# 01 · Pré-requisitos

Antes de instalar a stack, garanta que seu ambiente está preparado.

---

## ✅ Requisitos de sistema

| Requisito | Mínimo |
|---|---|
| Sistema Operacional | Windows 10/11 64-bit |
| RAM | 8 GB |
| Espaço em disco | 10 GB livres |
| Conexão com internet | Obrigatória durante o build |

---

## 🐳 Docker Desktop

### Instalar

1. Acessar [docker.com/products/docker-desktop](https://www.docker.com/products/docker-desktop/)
2. Clicar em **Download for Windows**
3. Executar o instalador
4. Durante a instalação, marcar:
   - ✅ **Use WSL 2 instead of Hyper-V**
   - ✅ **Add shortcut to desktop**
5. Reiniciar o computador após instalar

### Verificar instalação

Abrir o **Prompt de Comando (CMD)** e rodar:

```
docker --version
```

Resultado esperado:
```
Docker version 29.x.x, build xxxxxxx
```

---

## 🐧 WSL2 (Windows Subsystem for Linux)

O Docker Desktop requer o WSL2 para funcionar no Windows.

### Instalar o WSL2

Abrir o **PowerShell como Administrador** e rodar:

```powershell
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
```

**Reiniciar o computador.**

Após reiniciar, baixar e instalar o pacote do kernel WSL2:
```
https://aka.ms/wsl2kernel
```

Definir o WSL2 como padrão:
```
C:\Windows\System32\wsl.exe --set-default-version 2
```

### Instalar o Ubuntu

```
C:\Windows\System32\wsl.exe --install -d Ubuntu
```

Aguardar a instalação, criar usuário e senha quando solicitado.

### Verificar WSL2

```
C:\Windows\System32\wsl.exe --status
```

Resultado esperado:
```
Distribuição Padrão: Ubuntu
Versão Padrão: 2
```

---

## ⚠️ Problemas comuns

**Docker fica em loop "Starting":**
O WSL2 não está instalado ou configurado. Seguir os passos acima.

**`wsl` não é reconhecido como comando:**
Usar o caminho completo: `C:\Windows\System32\wsl.exe`

**`docker` não é reconhecido após instalar:**
Fechar e abrir um novo terminal após o Docker Desktop ficar verde.

---

[← Voltar ao README](../README.md) | [Próximo: Instalação →](02-instalacao.md)
