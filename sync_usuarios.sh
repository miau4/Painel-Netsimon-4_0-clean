#!/bin/bash
# ==========================================
#   NETSIMON 4.0 - SINCRONIZAÇÃO DE USUÁRIOS
#   Converte: login limite → login|uuid|expira|senha|limite
# ==========================================

SOURCE="/root/usuarios.db"
TARGET="/etc/painel/usuarios.db"

[ ! -f "$SOURCE" ] && touch "$SOURCE"
[ ! -f "$TARGET" ] && touch "$TARGET"

cp "$TARGET" "$TARGET.bak" 2>/dev/null

# Limpa target
> "$TARGET"

# Processa source
while IFS=' ' read -r login limite; do
    [ -z "$login" ] && continue
    [ -z "$limite" ] && limite=1
    
    # Gera UUID e data padrão
    uuid=$(cat /proc/sys/kernel/random/uuid)
    expira=$(date -d "+30 days" '+%Y-%m-%d %H:%M:%S')
    senha="netsimon"
    
    # Grava com 5 campos: login|uuid|expira|senha|limite
    echo "$login|$uuid|$expira|$senha|$limite" >> "$TARGET"
done < "$SOURCE"
