## MySQL server has gone away

«MySQL server has gone away» — такая ошибка может возникнуть в долгоживущем приложении использующего SQLAlchemy. Всё понятно, прекратилось соединение с mysql сервером, превышен лимит времени отведённого на бездействие. В руководстве к SQLAlchemy сказано выставить период обновления пула сокетов: _pool_recycle_
```python
db_engine = create_engine(
    DATABASE_CONNECTION_INFO,
    pool_size=100,
    pool_recycle=3600
)
```

Уменьшил время с 3600 до 60 секунд — не помогло. [На Stackoverflow нашёл интересное решение](http://stackoverflow.com/questions/18054224/python-sqlalchemy-mysql-server-has-gone-away), в котором автор ссылается [на не менее интересный доклад](http://discorporate.us/jek/talks/SQLAlchemy-EuroPython2010.pdf). Ей-богу, доклад интересный, рекомендую. Так вот, в чем решение: 

- протестировать работоспособность подключения
- если оно «мертво», то вызываем sqlalchemy.DisconnectionError
- После чего пул заменит это «мёртвое» соединение одним свеженьким

Вы знаете, отлично работает. В отладочных логах Celery я вижу сообщение:








## Перевести

http://alextechrants.blogspot.ru/2013/11/10-common-stumbling-blocks-for.html
http://lucumr.pocoo.org/2011/7/19/sqlachemy-and-you/
