# Поддержка кириллицы в консоли

Список поддерживаемых локалей:  
```bash  
less /usr/share/i18n/SUPPORTED  
```  
Включаем нужную локаль:  
```bash  
sudo locale-gen ru_RU.utf8  
sudo dpkg-reconfigure locales  
```

```bash  
sudo dpkg-reconfigure console-setup  
```

   * Выбираем UTF-8

   * Выбираем Кирилица - славянские языки (5 пункт)

   * Выбираем TerminusBold

   * Выбираем 16


**ВНИМАНИЕ!**

сразу же делаем следующий пункт, иначе придется «продираться» через кракозябры по настройкам.  
```bash  
sudo apt-get install console-cyrillic  
```
