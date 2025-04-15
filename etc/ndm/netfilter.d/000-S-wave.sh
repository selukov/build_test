#!/bin/sh

# Путь к JSON-файлу с настройками
SETTING="/opt/etc/swave/settings.json"

# Извлекаем port_forwarding_list из JSON файла
port_forwarding_list=$(jq -r '.network.port_forwarding_list | join(",")' $SETTING)

# Выводим значение для проверки
echo "Извлеченные порты: $port_forwarding_list"

# Если вам нужен массив, можно преобразовать строку в массив
IFS=',' read -ra ports_array <<< "$port_forwarding_list"

# Пример использования массива
echo "Доступные порты:"
for port in "${ports_array[@]}"; do
    echo "- $port"
done