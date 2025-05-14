#!/bin/bash

# 1. Определяем путь к dockerd
DOCKERD_PATH=$(which dockerd)

# 2. Добавляем автозапуск в ~/.bashrc (если ещё не добавлен)
AUTOSTART_LINE="if ! pgrep -x dockerd > /dev/null; then sudo $DOCKERD_PATH > /dev/null 2>&1 & fi"

if ! grep -Fxq "$AUTOSTART_LINE" ~/.bashrc; then
  echo -e "\n# Автозапуск Docker daemon" >> ~/.bashrc
  echo "$AUTOSTART_LINE" >> ~/.bashrc
  echo "[+] Добавлено в ~/.bashrc"
else
  echo "[=] Автозапуск уже есть в ~/.bashrc"
fi

# 3. Настраиваем запуск dockerd без пароля (sudoers)
USERNAME=$(whoami)
SUDOERS_LINE="$USERNAME ALL=(ALL) NOPASSWD: $DOCKERD_PATH"

# Создаём temp-файл и редактируем через visudo
TEMP_FILE=$(mktemp)
sudo cp /etc/sudoers $TEMP_FILE
if ! grep -qF "$SUDOERS_LINE" $TEMP_FILE; then
  echo "$SUDOERS_LINE" | sudo tee -a /etc/sudoers > /dev/null
  echo "[+] Разрешён запуск dockerd без пароля"
else
  echo "[=] В sudoers уже есть разрешение на dockerd"
fi

echo -e "\n✅ Готово! Перезапусти WSL или выполни:"
echo "    source ~/.bashrc"
echo "Чтобы проверить: docker run hello-world"
