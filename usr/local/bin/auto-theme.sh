#!/bin/bash
#
# Autor:           Fernando Souza - https://www.youtube.com/@fernandosuporte/
# Data:            20/06/2025-18:53:24
# Atualização em:  https://github.com/tuxslack/mako
# Script:          auto-theme.sh
# Versão:          0.1
# 
#
# Data da atualização:  
#
# Licença:  MIT
# 
#
# Requer: find mako makoctl

# Alternância Automática (Clarear/Escurecer por Horário).


# Esse script bash serve para alternar o tema de notificações do mako (um daemon de 
# notificações usado em ambientes Linux com Wayland), de acordo com o horário do dia, 
# utilizando temas da paleta Catppuccin. 


# 🎨 Temas principais da Catppuccin:

# Tema          Tipo                       Descrição breve

# Latte      ☀️ Claro	       Para ambientes claros. Tons suaves e leves.
# Frappé     🌤 Médio	       Tema  mais escuro que Latte, mas não tão escuro quanto os demais.
# Macchiato  🌙 Escuro	       Equilíbrio entre contraste e suavidade. Muito usado como dark theme padrão.
# Mocha      🌑 Escuro	       O mais escuro e contrastante. Ótimo para setups noturnos.


# 🖌 Exemplos de aplicações:

#     Latte              → Ideal para uso diurno
#
#     Mocha / Macchiato  → Preferido à noite ou em ambientes escuros
#
#     Frappé             → Uma opção intermediária, escura mas menos intensa que Mocha



# Você pode usar o script com cron.


# Com cron (executar de hora em hora):

# Abra o crontab com:

# crontab -e

# Adicione:

# 0 * * * * /usr/local/bin/auto-theme.sh


# ou


# Para configurar o cron para executar um script que alterna entre tema claro e escuro com 
# base no horário, você pode criar duas tarefas no crontab:

#     Uma que ativa o tema claro às 6h00.

#     Outra que ativa o tema escuro às 18h00.


# Exemplo de configuração no crontab:

# 0 6  * * * /home/SEU_USUARIO/.config/mako/auto-theme.sh

# 0 18 * * * /home/SEU_USUARIO/.config/mako/auto-theme.sh




# Quais as paleta de cor Catppuccin para tema mako?


# 🎨 Paleta padrão (exemplo: Frappé)

#     Rosewater: #f2d5cf

#     Flamingo: #eebebe

#     Pink: #f4b8e4

#     Mauve: #ca9ee6

#     Red: #e78284

#     Maroon: #ea999c

#     Peach: #ef9f76

#     Yellow: #e5c890

#     Green: #a6d189

#     Teal: #81c8be

#     Sky: #99d1db

#     Sapphire: #85c1dc

#     Blue: #8caaee

#     Lavender: #babbf1

#     Text: #c6d0f5

#     Subtext 1: #b5bfe2

#     Subtext 0: #a5adce

#     Overlay 2: #949cbb

#     Overlay 1: #838ba7

#     Overlay 0: #737994

#     Surface 2: #626880

#     Surface 1: #51576d

#     Surface 0: #414559

#     Base: #303446

#     Mantle: #292c3c

#     Crust: #232634


# Essas cores incluem desde os tons de fundo (base, surface, mantle, crust) até os tons 
# de texto e sobreposição, e são apropriadas para notificações Mako (fundo, borda, texto, 
# ações).


# https://catppuccin.com/
# https://github.com/catppuccin


clear


for cmd in find mako makoctl; do

    command -v "$cmd" >/dev/null 2>&1 || { echo "Erro: comando '$cmd' não encontrado." >&2; exit 1; }

done


# 🕐 Captura a hora atual (de 00 a 23) e guarda na variável HOUR.

HOUR=$(date +%H)


# 🌓 Condicional

#     Se a hora estiver entre 6h e 17h59, aplica o tema claro.

#     Caso contrário (entre 18h e 5h59), aplica o tema escuro.


if [ "$HOUR" -ge 6 ] && [ "$HOUR" -lt 18 ]; then


    # Tema light

    echo -e "\nTema mako claro definido: `date +%d/%m/%Y-%H-%M-%S` \n"

    rm -f ~/.config/mako/config

    ln -sf ~/.config/mako/catppuccin-latte/catppuccin-latte-sky  ~/.config/mako/config

else

    # Tema dark

    echo -e "\nTema mako escuro definido: `date +%d/%m/%Y-%H-%M-%S` \n"

    rm -f ~/.config/mako/config

    ln -sf  ~/.config/mako/catppuccin-frappe/catppuccin-frappe-blue ~/.config/mako/config

fi


# 🔄 Recarrega o mako para aplicar as novas configurações imediatamente.

makoctl reload


# Para testar

# notify-send "Teste de Tema" "Se você está vendo esta notificação, o tema está aplicado."

exit 0

