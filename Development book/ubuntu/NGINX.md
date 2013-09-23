https://github.com/darktable/html5-boilerplate-server-configs/blob/master/nginx.con
https://github.com/Umkus/nginx-boilerplate


 location /assets/ {
                gzip_static on; 
                expires max;
                add_header Cache-Control public;
        add_header Access-Control-Allow-Origin *;
        }  


## How do I add Access-Control-Allow-Origin in NGINX?

Nginx has to be compiled with [http://wiki.nginx.org/NginxHttpHeadersModule](http://wiki.nginx.org/NginxHttpHeadersModule). Then you can do this

``` nginx
location ~* \.(eot|ttf|woff)$ {
    add_header Access-Control-Allow-Origin *;
}
```

----------------

## ngx_http_gzip_static_module

Этот модуль позволяет избавиться от сжатия снова и снова одних и тех же файлов. Мы просто максимально сжимаем их заранее, и кладем в том же каталоге с расширением .gz, и если они есть – то будет отдаваться сжатый файл и очень быстро

------------

## Как то можно вывести на экран текущую действующую конфигурацию, которую nginx собрал из разных подключаемых файлов и применяет?

[Вот так.](http://serverfault.com/a/361465) [Нативная поддержка](http://tengine.taobao.org/document/commandline.html) есть в [tengine](http://tengine.taobao.org/.

-------------------


