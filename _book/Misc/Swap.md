# Swap

## Есть ли в системе swap? 
С малым количеством памяти и без swap-файла может падать mysql, например.

```bash
cat /proc/swaps

free -m
top -b |head -n5
```

## Если нет, то делаем
```bash
sudo -s

# count=1024 — размер swap-файла. Обычно выбирают размер равным или удвоенным количеством оперативной памяти
dd if=/dev/zero of=/swapfile bs=1M count=1024
mkswap /swapfile 
chown root. /swapfile && chmod 0600 /swapfile 
swapon /swapfile

# В файл /etc/fstab добавляем строку, чтобы при перезагрузке
# системы swap автоматически монтировался
echo /swapfile swap swap defaults 0 0 >> /etc/fstab

exit
```


## Управляем интенсивностью использования swap
Интенсивностью использования swap управляет системный параметр swappiness. Значение swappiness может быть от 0 до 100 и по умолчанию, в Ubuntu, равно 60. Если swappiness=100, то система перейдёт на максимальную интенсивность использования swap, и, наоборот, при значении 0, система будет стараться избегать использования swap. 
```bash
# Узнать текучее значение swappiness
cat /proc/sys/vm/swappiness

# Установить значение для текущего сеанса
sudo sysctl vm.swappiness=10

# Теперь значение сохранится при перезагрузке системы
echo vm.swappiness = 0 >> /etc/sysctl.conf && sysctl -p
```
