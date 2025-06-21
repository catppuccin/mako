#!/bin/bash
#
# Autor:           Fernando Souza - https://www.youtube.com/@fernandosuporte/
# Data:            20/06/2025-18:53:24
# Atualização em:  https://github.com/tuxslack/mako
# Script:          alternador-de-tema-mako.sh
# Versão:          0.1
# 
#
# Data da atualização:  
#
# Licença:  MIT
# 
#
# Requer: yad find mako makoctl cut sort notify-send


# Script em Bash que usa o yad (Yet Another Dialog) para gerenciar os temas 
# do Mako (notificador do Wayland) localizados em ~/.config/mako/.


# https://catppuccin.com/
# https://github.com/catppuccin


clear


for cmd in yad find mako makoctl cut sort notify-send; do

  command -v "$cmd" >/dev/null 2>&1 || { echo "Erro: comando '$cmd' não encontrado." >&2;  yad --center --title="❌ Tema para Mako" --text="Erro: comando '$cmd' não encontrado." --buttons-layout=center --button="OK":0 ; exit 1; }

done



yad --center --title="✅ Tema para Mako" --text="

Uso:

Copie o conteúdo da versão de sua escolha de themes/ para $HOME/.config/mako/config.

Recarregue o mako com makoctl reload.


https://github.com/catppuccin/mako


Ex:

cd ~/

git clone https://github.com/catppuccin/mako.git

cd mako/

mv -i themes/* $HOME/.config/mako/

" \
--buttons-layout=center \
--button="OK":0



THEMES_DIR="$HOME/.config/mako"
CONFIG_FILE="$THEMES_DIR/config"

# THEMES=$(find "$THEMES_DIR" -maxdepth 1 -type f ! -name "config" -exec basename {} \;)


# Lista arquivos que:
# - São arquivos comuns
# - Não se chamam 'config'
# - Não terminam com .sh, .log, .desktop ou .txt


# THEMES=$(find "$THEMES_DIR" -maxdepth 2 -type f \
#     ! -name "config" \
#     ! -name "*.sh" \
#     ! -name "*.txt" \
#     ! -name "*.log" \
#     -exec basename {} \; | sort)


THEMES=$(find "$THEMES_DIR" -maxdepth 2 -type f \
    ! -name "config" \
    ! -name "*.desktop" \
    ! -name "*.sh" \
    ! -name "*.txt" \
    ! -name "*.log" | sort)

# -maxdepth 1: limita a busca a apenas esse diretório, sem entrar em subpastas.
# Ou seja, só os arquivos e pastas que estão diretamente dentro de THEMES_DIR.

# O -maxdepth 2 faz o find buscar arquivos em até dois níveis de profundidade dentro da pasta $THEMES_DIR.

# Vai pegar os nomes de arquivos listados e ordenar alfabeticamente.

if [ -z "$THEMES" ]; then

    yad --center --title="Temas do Mako" --text="❌ Nenhum tema encontrado em $THEMES_DIR" --buttons-layout=center --button="OK":0

    exit 1

fi

# echo "$THEMES"



SELECTED=$( echo "$THEMES" | awk '{ print "🎨 " $0 }' | yad \
    --center \
    --list \
    --separator="|" \
    --title="Escolher tema do Mako" \
    --column="Tema" \
    --buttons-layout=center \
    --button="Cancelar":1 --button="OK":0 \
    --width="800" --height="850")

SELECTED=$(echo "$SELECTED" | cut -d'|' -f1)

# echo "$SELECTED"


if [ -z "$SELECTED" ]; then

    exit 0

fi





# Remove emoji 🎨 para obter o nome do arquivo

SELECTED=$(echo "$SELECTED" | sed 's/^🎨 //')


# Tema: catppuccin-latte-sky

ls -l "$CONFIG_FILE" > "$THEMES_DIR"/tema_antigo.log



# cp "$THEMES_DIR/$SELECTED" "$CONFIG_FILE"

rm -Rf "$CONFIG_FILE"

sleep 1

ln -sf "$SELECTED" "$CONFIG_FILE"


# ls -l "$CONFIG_FILE"
# ls    "$SELECTED"


# Recarregue o mako

makoctl reload


SELECTED=$(basename "$SELECTED")

echo -e "\nTema \"$SELECTED\" aplicado com sucesso.\n"

notify-send "Teste de Tema" "Se você está vendo esta notificação, o tema está aplicado."

yad --title="✅ Tema aplicado" --text="Tema \"$SELECTED\" aplicado com sucesso." --buttons-layout=center --button="OK":0


exit 0

