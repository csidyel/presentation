# Add to current docs:

### 1. How to deploy using FTP

Semaphore comes with LFTP installed in the base image. We recommend creating a secret and set the variables `FTP_USER` and `FTP_PASSWORD`. Then, using a promotion you may deploy your application with the following command:

```bash
lftp -c "open -u $FTP_USER,$FTP_PASSWORD YOUR_FTP_HOST; set ssl:verify-certificate no; mirror -R ./ YOUR_REMOTE_PATH"
```

Note that it's necessary to replace `YOUR_FTP_HOST` and `YOUR_REMOTE_PATH` with the correspondent values.


# FAQ:

Q: Job got stuck on `ssh-add ~/.keys/*`

A: The key might be protected by a passphrase. We recommend generating a new key without a passphrase in an [SSH debug session][]. You may achieve this with the following command:

```bash
ssh-keygen -f ~/.ssh/<your-key> -t rsa -N "" && cat ~/.ssh/<your-key>
```
[SSH debug session]: https://docs.semaphoreci.com/use-cases/debugging-with-ssh-access/


Q: The pipeline is running but jobs are not starting.

A: It's possible that you've hit the [quota limit][] for the machine type used in the pipeline. Maybe there are too many jobs running in parallel or an SSH session is hung, also consuming quota. 

We recommend using `sem get jobs` to get the list of all running jobs, including SSH sessions. Then you may stop any job with [sem stop][]

[quota]: https://docs.semaphoreci.com/article/133-quotas-and-limits
[sem stop]: https://docs.semaphoreci.com/article/53-sem-reference#sem-get-examples

