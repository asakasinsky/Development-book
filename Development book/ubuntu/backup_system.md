

scp -r hosting@locum.ru:~/backups/db ~/Workspace/Backups/idbi
patch < разница.diff

00 16 * * * mysqldump -u root -ppassword --all-databases | gzip > /home/vagrant/backups/database.`date +"\%Y-\%m-\%d"`.sql.gz


20 16 * * * scp -r hosting@locum.ru:~/backups/db ~/Documents/Яндекс.Диск/Backups/idbi

00  * * * * rsync -az ~/Workspace ~/Яндекс.Диск/Backups


--------------

при создании сайта:


   * создаем папку бекапа этого сайта
   * Создаем скрипт бэкапа MySQL базы и папки сайта
   * Добавляемся в задачу Crone

Crone снимает бэкапы каждый день в папку 





