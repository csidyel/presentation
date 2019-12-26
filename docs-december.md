### Add to current docs:

1. How to deploy using FTP

Semaphore comes with LFTP installed in the base image. We recommend creating a secret and set the variables FTP_USER and FTP_PASSWORD. Then, using a promotion you may deploy your application with the following command:

`lftp -c "open -u $FTP_USER,$FTP_PASSWORD YOUR_FTP_HOST; set ssl:verify-certificate no; mirror -R ./ YOUR_REMOTE_PATH"`

Note that it's necessary to replace YOUR_FTP_HOST and YOUR_REMOTE_PATH with the correspondent values.





### FAQ:

Q: Job got stuck on `ssh-add ~/.keys/*`

A: The key might be protected by a passphrase. The easiest solution is to generate a new key without a passphrase 
in an [SSH debug session]: https://docs.semaphoreci.com/use-cases/debugging-with-ssh-access/. You may achieve this by running the following command and then update the key:
