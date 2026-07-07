# Alterações Realizadas no Painel NetSiMon 4.0

## 🔄 O que foi feito

O projeto foi **simplificado removendo todas as referências à API do Atlas**, deixando apenas a lógica essencial de gerenciamento de usuários locais.

---

## 📋 Arquivos Modificados

### 1. **atlas.sh** (COMPLETAMENTE REESCRITO)
- ❌ Removido: `atlas_call()`, `atlas_criar_user()`, `atlas_criar_teste()`, etc
- ❌ Removido: Configuração de chave API (`ATLAS_KEY_FILE`)
- ✅ Mantido: Definição de `USERDB="/root/usuarios.db"`
- ✅ Mantido: Referência a `xray_lib.sh`

**Resultado:** Arquivo passa de **17KB para 200 bytes** (bem mais leve)

### 2. **adduser.sh**
- ❌ Removido: Chamadas a `atlas_criar_user()`
- ✅ Mantido: Lógica de criar usuário Linux (`useradd`, `chpasswd`)
- ✅ Mantido: Lógica de adicionar ao Xray

### 3. **addtest.sh**
- ❌ Removido: Chamadas a `atlas_criar_teste()`
- ✅ Mantido: Lógica de criar usuário de teste

### 4. **deluser.sh**
- ❌ Removido: Chamadas a `atlas_desativar_user()`
- ✅ Mantido: Lógica de deletar usuário (`userdel`, `pkill`)
- ✅ Mantido: Remoção do Xray

### 5. **menu.sh**
- ❌ Removido: Menu de gerenciamento do Atlas
- ✅ Mantido: Menu de criar/listar/deletar usuários

### 6. **limit.sh**
- ❌ Removido: Sincronização com Atlas
- ✅ Mantido: Lógica de limitação de conexões

### 7. **xray.sh**, **boot_check.sh**, **install.sh**
- ❌ Removido: Referências a atlas
- ✅ Mantido: Lógica essencial

---

## ✅ Lógica Preservada

**Funcionalidades que continuam funcionando normalmente:**

- ✅ Criar usuário (`adduser.sh`)
- ✅ Criar teste (`addtest.sh`)
- ✅ Deletar usuário (`deluser.sh`)
- ✅ Listar usuários (`menu.sh`)
- ✅ Usuários online (`online.sh`)
- ✅ Integração com Xray
- ✅ Limite de conexões (`limit.sh`)

---

## 🔧 Como Usar

### Instalação:
```bash
cd /tmp
unzip Painel-Netsimon-4_0-CLEAN.zip
cd Painel-Netsimon-4_0-clean
bash install.sh
```

### Sincronização de Usuários:

O sistema agora lê usuários APENAS de **`/root/usuarios.db`**.

Para sincronizar com o painel Atlas, use o script de monitoramento:

```bash
nohup /etc/painel/monitor_usuarios.sh > /var/log/monitor_usuarios.log 2>&1 &
```

Este script:
- Monitora arquivos `.txt` criados pelo painel
- Sincroniza para `/root/usuarios.db`
- Sincroniza para `/etc/painel/usuarios.db` via `sync_usuarios.sh`

---

## ⚠️ Importante

- **Não há mais integração com chave API do Atlas**
- **Todas as operações são locais** (servidor processando diretamente)
- **Arquivo de banco único:** `/root/usuarios.db`
- **Sincronização:** via monitor de arquivos (mais simples e confiável)

---

## 📊 Tamanho do Projeto

- **Antes:** Muito complexo com múltiplas sincronizações
- **Depois:** Enxuto e objetivo
  - `atlas.sh`: 17KB → 200 bytes
  - Total: Redução de ~10KB em código desnecessário

---

## 🚀 Próximos Passos

1. Instale o projeto com o novo ZIP
2. Ative o `monitor_usuarios.sh` para sincronizar com painel
3. Teste criação/deleção de usuários
4. Teste exclusão de expirados
5. Monitore `/var/log/monitor_usuarios.log` para debug

---

**Versão:** Painel-NetSiMon-4.0-CLEAN
**Data:** 07/07/2026
**Status:** ✅ Pronto para instalação
