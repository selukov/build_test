#!/bin/sh

# Путь к JSON-файлу с настройками
SETTING="/opt/etc/swave/settings.json"

get_clean_json() {
  awk '
  BEGIN { in_string = 0 }
  {
    line = $0
    result = ""
    for (i = 1; i <= length(line); i++) {
      char = substr(line, i, 1)
      next_char = substr(line, i+1, 1)
      if (char == "\"" && prev != "\\") {
        in_string = !in_string
      }
      if (!in_string && char == "/" && next_char == "/") {
        break
      }
      result = result char
      prev = char
    }
    print result
  }' "$1"
}

js_SETTING=$(get_clean_json "$SETTING" | jq -c '.' 2>/dev/null) # Передаем путь к JSON-файлу


echo "$js_SETTING"

port_forwarding_list=$(echo "$js_SETTING" | jq -r '.network.port_forwarding_list | join(",")')

# Извлекаем port_forwarding_list из JSON файла
#port_forwarding_list=$(jq -r '.network.port_forwarding_list | join(",")' $SETTING)

# Выводим значение для проверки
echo "Извлеченные порты: $port_forwarding_list"