# Shell

Я использую связку iTerm + Z shell + tmux

iTerm — отличная замена штатному терминалу в Mac OS.  Z shell (Zsh) — замена стандартному BASH, имеет отличный автокомплит, умеет исправлять опечатки в командах, развертывает путь по первым буквам директорий. Отличная презентация на тему «Почему Z shell круче твоего шелла» лежит в закромах [SlideShare](http://www.slideshare.net/jaguardesignstudio/why-zsh-is-cooler-than-your-shell-16194692). Tmux — менеджер терминалов, проще говоря, в одном окне можно работать с несколькими терминалами одновременно.  

Пример: в одном  терминале связываемся с удалённым сервером по SSH, в другом работает Grunt или Gulp, а третий открыт на всякий случай, вдруг придётся сделать коммит. В моей конфигурации ещё есть место для Midnight Commander и htop. Переключаюсь между окнами по ALT + правая или левая стрелка. Размер терминалов внутри окна можно регулировать с помощью мышки.

## iTerm 

iTerm предлагалось установить [ранее](./Apps.md), самое время запустить его.

## Переключимся на Z shell

```bash
brew install zsh
brew install zsh-completions
```

```bash
which -a zsh
> /usr/local/bin/zsh
> /bin/zsh
```

Добавим путь к zsh в список остальных шеллов /etc/shells
```bash
sudo nano /etc/shells
```

Сменим текущий шелл
```bash
chsh -s /usr/local/bin/zsh
```

После перезагрузки или логаута (можно просто закрыть iTerm и открыть его снова)
```bash
echo $SHELL

> /usr/local/bin/zsh
```

```bash
echo $ZSH_VERSION
> 5.0.7
```


## Установим Oh-my-zsh

[Тут](https://github.com/robbyrussell/oh-my-zsh/wiki/Plugins) можно почитать о плагинах к фреймворку Oh-my-zsh

```bash
curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
```


## Установим tmux
К сожалению, tmux конфликтует с launchctl.

```bash
brew install tmux
```


## Скачаем файлы конфигурации

Очень рекомендую заглянуть внутрь файлов и попытаться понять что там и как.
```bash
wget -O ~/.zshrc   https://raw.githubusercontent.com/asakasinsky/Development-book/master/OSX/shell/.zshrc  
wget -O ~/.tmux.conf   https://raw.githubusercontent.com/asakasinsky/Development-book/master/OSX/shell/.tmux.conf  
mkdir -p ~/Scripts
wget -O ~/Scripts/tmux_work.sh   https://raw.githubusercontent.com/asakasinsky/Development-book/master/OSX/shell/Scripts/tmux_work.sh  
```


## Запуск

```bash
. ~/.zshrc
```

Закроем все окна iTerm и откроем новое. Должно всё получиться.



## Шрифт

В качестве консольного шрифта и шрифта для кода мне очень нравится шрифт Inconsolata LGC. [По этой ссылке ](https://github.com/asakasinsky/Inconsolata-LGC/archive/master.zip) можно скачать архив с готовыми ttf, включающими в себя кириллические и Powerline глифы. Powerline совместимость нужна для zsh-темы «agnoster».

### Powerline
Если необходимо, то можно пропатчить свой любимый шрифт для совместимости с Powerline. Для примера возьмем [DejaVu Sans Mono](http://dejavu-fonts.org/wiki/Download).


Сначала нужно будет установить XQuartz (смотри [Apps](./Apps.md))


Теперь устанавливаем fontforge с привязкой к python:
```bash
brew install fontforge --with-python
brew linkapps fontforge
```


Скачиваем  powerline-fontpatcher:
```bash
mkdir -p ~/Tmp
git clone https://github.com/Lokaltog/powerline-fontpatcher.git ~/Tmp/powerline-fontpatcher
```


Скачиваем, патчим и устанавливаем шрифт:
```bash
mkdir -p ~/Tmp && cd ~/Tmp
wget http://sourceforge.net/projects/dejavu/files/dejavu/2.34/dejavu-fonts-ttf-2.34.tar.bz2
mkdir -p dejavu-fonts
tar -C dejavu-fonts -xvzf dejavu-fonts-ttf-2.34.tar.bz2
cd dejavu-fonts
find dejavu-fonts-ttf-2.34 -name \*.ttf -exec fontforge -script ~/Tmp/powerline-fontpatcher/scripts/powerline-fontpatcher {} \;
mv *.ttf ~/Library/Fonts
```
