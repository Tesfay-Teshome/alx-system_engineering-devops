# Error 504 while trying to reach a particular URL

## Site outage report and incident report for 504 errors
Anyone attempting to access a website received a 504 error on December, 03, 2022 at midnight due to a server access issue. Background on the LAMP stack on which the server is built.
### Timeline
•0:00 PST - Anyone attempting to visit the website will receive a 500 error
•00:05 PST - Ensuring that MySQL and Apache are operational.
 When the website was checked at 
•00:10 PST, it was discovered that the database and server were both operating as intended. After a brief restart, the A pache server returned a result of 200 and OK when attempting to curl the website
•00:12 PST. Reviewing error logs at 00:18 PST to see if we can identify the source of the problem.
•00:25 PST, Check /var/log at to check if the Apache server was abruptly shut down. There was no sign of the PHP error l og
•00:30 PST, Checking the PHP.ini settings at indicated that all error logging has been disabled. activating error loggin g
•00:32 PST - Restarting the apache server and checking the php error logs to see what is being recorded.
•00:36 PST, Reviewing PHP error logs showed a misspelled file name that was causing erroneous loading and an early shutd own of Apache.
•00:38 PST. Fixing the file name and restarting Apache 
 Server is presently operating regularly as of 
•00:40 PST, and the website is loaded as intended.


## Cause and effect and solution
The problem was caused by the wp-settings.php file referencing the incorrect file name. The server responded with a 500-error code when the user attempted to curl it. Checking the error logs revealed that no error log file was being written for the PHP failures, and reading the normal Apache error log did not reveal much about the server's early shutdown. The engineer decided to investigate the php.ini file's error log option after seeing that the php log errors were not being routed anywhere, and discovered that all error reporting was off. Once on, the Apache server's error logging system was restarted to see whether the log was recording any issues. The php log confirmed what was already suspected: a file with a.php extension was not there in the wp-settings.php file. It is obvious that the site access problem was caused by a typographical mistake. Since the problem was discovered on just one server, it's possible that it also occurred on other servers. The issue might be resolved quickly by using puppet to change the file extension, which would also affect other servers. After a brief deployment of the puppet code, all incorrect file extensions were quickly updated with the correct ones, and the server was restarted. This enabled the site and server to load correctly.
Correctional and Preventative Actions
•Error logging should be enabled on all servers and websites to make it simple to find faults when something goes wrong.
•Before deploying on a multi-server configuration, all servers and sites should be checked locally. This will allow issu es to be fixed before coming live and reduce the amount of time needed to resolve a downed site.
