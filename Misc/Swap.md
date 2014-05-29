### 1. Swap

Есть ли в системе swap? Без swap-файла mysql может падать.

```bash
cat /proc/swaps

free -m
top -b |head -n5
```

Если нет, то делаем:
```bash
# count=1024 — размер swap-файла. Обычно выбирают размер равным или удвоенным количеством оперативной памяти
dd if=/dev/zero of=/swapfile bs=1M count=1024
mkswap /swapfile
swapon /swapfile
```

В файл /etc/fstab добавляем строку
```bash
/swapfile swap swap defaults 0 0
```
