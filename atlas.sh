#!/bin/bash
# ==========================================
#   NETSIMON 4.0 - CONFIGURAÇÃO LOCAL
#   Versão simplificada sem Atlas API
# ==========================================

# Banco de usuários (sincronizado via monitor_usuarios.sh)
USERDB="/root/usuarios.db"
XRAY_CONF="/usr/local/etc/xray/config.json"
BASE="/etc/painel"

# Carrega biblioteca Xray
source "/etc/painel/xray_lib.sh" 2>/dev/null

# Fim do arquivo
