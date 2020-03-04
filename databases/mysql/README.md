### MySQL

Since most tools assume mysql 5.7, and the authentication mechanism changed in 8.0, `default_authentication_plugin=mysql_native_password` is used in mysql.cnf.

Once you have MySQL set up, you can create a web interface for management with `docker run --name myadmin --restart always -d --link theNameOfYourMysqlContainer:db -p 8080:80 phpmyadmin/phpmyadmin` which will start on :8080.