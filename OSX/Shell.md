# Shell

Я предлагаю использовать связку iTerm + Z shell + tmux

iTerm — отличная замена штатному терминалу в Mac OS.  Z shell (Zsh) — замена стандартному BASH, имеет отличный автокомплит, умеет исправлять опечатки в командах, развертывает путь по первым буквам директорий. Отличная презентация на тему «Почему Z shell круче твоего шелла» лежит в закромах [SlideShare](http://www.slideshare.net/jaguardesignstudio/why-zsh-is-cooler-than-your-shell-16194692). Tmux — менеджер терминалов, проще говоря, в одном окне можно работать с несколькими терминалами одновременно. Пример: в одном  терминале связываемся с удалённым сервером по SSH, в другом работает Grunt или Gulp, а третий открыт на всякий случай, вдруг придётся сделать коммит. В моей конфигурации ещё есть место для Midnight Commander и htop. Переключаюсь между окнами по ALT + правая или левая стрелка. Размер терминалов внутри окна можно регулировать с помощью мышки.

## iTerm 

iTerm предлагалось установить [ранее](https://github.com/asakasinsky/Development-book/blob/master/OSX/Apps.md), самое время запустить его.

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
echo $SHELLecho $SHELL

> /usr/local/bin/zsh
```

```bash
echo $ZSH_VERSION
> 5.0.5
```


## Установим Oh-my-zsh

[Тут](https://github.com/robbyrussell/oh-my-zsh/wiki/Plugins) можно почитать о плагинах к фреймворку Oh-my-zsh

```bash
curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
```


## Установим tmux

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

