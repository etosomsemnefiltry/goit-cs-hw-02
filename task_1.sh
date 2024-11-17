#!/bin/bash

sites=("google.com" "facebook.com" "twitter.com")
log_file="access.log"

echo "=== Проверка сайтов: $(date) ===" >> "$log_file"
echo "Сайты ${sites[@]}"

for site in ${sites[@]};
do
    response=$(curl -s -L --head --request GET "$site") 

    if echo "$response" | grep -q "HTTP/2 200"; then
        stat="${site} is UP"
    elif echo "$response" | grep -q "HTTP/1.1 301"; then
        stat="${site} is UP"
    else
        stat="${site} Unknown header"
    fi
        echo "$stat" | tee -a "$log_file"
done 
echo "Результат сканирования записан в лог файл access.log"