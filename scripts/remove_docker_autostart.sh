#!/bin/bash

# 1. Удаляем строку автозапуска из ~/.bashrc
AUTOSTART_LINE="if ! pgrep -x dockerd > /dev/null; then sudo $(which dockerd) > /dev/null 2>&1 & fi"

if grep -Fxq "$AUTOSTART_LINE" ~/.bashrc; then
  sed -i "\|$AUTOSTART_LINE|d" ~/.bashrc
  echo "[–] Удалена строка автозапуска из ~/.bashrc"
else
  echo "[=] Строка автозапуска не найдена в ~/.bashrc"
fi

# 2. Удаляем разрешение из sudoers (если оно есть)
USERNAME=$(whoami)
DOCKERD_PATH=$(which dockerd)
SUDOERS_LINE="$USERNAME ALL=(ALL) NOPASSWD: $DOCKERD_PATH"

# Создаём резервную копию
sudo cp /etc/sudoers /etc/sudoers.bak

# Удаляем строку через ed (более безопасно)
sudo ed -s /etc/sudoers <<< $'/^'"$SUDOERS_LINE"'/d\nw'

echo "[–] Правило sudoers удалено (если было)"
echo "✅ Готово! Для отмены полностью — перезапусти WSL или выполни:"
echo "    source ~/.bashrc"
