http://habrahabr.ru/post/106912/


## Из локального репозитория 

cd /path/to/my/repo

git init
git add .
git commit -m "Initial commit"

git remote add origin git@bitbucket.org:asakasinsky/tng.git

Слить мастер-ветку 
Мы считаем ветку origin/master главной. То есть, исходный код в ней должен находиться в состоянии production-ready в любой произвольный момент времени.
git push origin master


Ветвь origin/develop мы считаем главной ветвью для разработки. Хранящийся в ней код в любой момент времени должен содержать самые последние изданные изменения, необходимые для следующего релиза. Эту ветку также можно назвать «интеграционной». Она служит источником для сборки автоматических ночных билдов.

git checkout -b develop
git push origin develop



При начале работы над новой функциональностью делается ответвление от ветви разработки (develop).

git checkout -b myfeature develop



Добавление завершённой функциональности в develop

Завершённая функциональность (фича) вливается обратно в ветвь разработки (develop) и попадает в следующий релиз.

$ git checkout develop
Switched to branch 'develop'
$ git merge --no-ff myfeature
Updating ea1b82a..05e9557
(Отчёт об изменениях)
$ git branch -d myfeature
Deleted branch myfeature (was 05e9557).
$ git push origin develop






## git branch — создание, перечисление и удаление веток

Список веток
git branch

Создать ветку feature-name
git branch feature-name


git branch -d new-branch — удалит ветку, если та была залита (merged) с
разрешением возможных конфликтов в текущую.

git branch -D new-branch — удалит ветку в любом случае.

git branch -m new-name-branch — переименует ветку.

## Загрузить изменения

Как только вы сделали работу (или её часть), отправьте её в свою копию репозитория на GitHub:

#Загружает изменения в текущей ветви в origin в ветвь feature-name
git push origin feature-name 




## Что следует делать, если работа заняла большое время и оригинальный репозиторий успел уйти вперёд?

Можно просто влить изменения из оригинального репозитория к себе:

```git
git checkout master
git pull upstream master
git checkout feature
git merge master
```

Однако хозяину оригинального репозитория или, может быть, даже вам, не понравится наличие мёрж-коммитов и коммитов из master'а в списке коммитов на пулл. В таком случае вам стоит воспользоваться git rebase.

```git
git checkout master
git pull upstream master
git checkout feature
git rebase master #Всё отличие только здесь
```

Прочитать про то, как работает rebase можно в официальном руководстве. Там имеются и очень понятные иллюстрации. Так же есть статья в помощи GitHub.
ВНИМАНИЕ: Пожалуйста, учтите, что git rebase меняет id коммитов! Поэтому, все действия с этой командой стоит выполнять только на локальном репозитории, до того, как эти коммиты станут общедоступны, т.е. до того, как вы их push'нули на гитхаб.
