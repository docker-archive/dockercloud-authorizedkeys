#!/bin/bash
set -e
docker build -t sut .
rm -fr .test
mkdir .test
KEY="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCjHJxGBGgPKfkPk6UDJB6ZK6COcGvJpVcXmptcRRN7qYE44Ei4KXLUGB6cgqkjFeEk2Z5HCSrC05NQgX1+blhAan+RfPtvuJzCaZPyVaJwezbspJi6UbjfV6wgJa8kNA819+ggDuKyjy7yA5KtJecxhKK5WfEbuwbDDVrl5ogQbm+Gj4ThK24rcjMoE3MSAcjj8oxIv0jg6jzzF55dOh2pKWkEo6gBZRrNlD+QQTdYRrmfu8vTGC8UYWPCGKEY5pvopF9kp24emM6zWio4RWOjIbC3nZrTyh5HgUXDN8bG/xeajKQAJBxtNI+/tP+cJDou73H9fK97MSD+pBETybON"
docker run -v $(pwd)/.test:/user -e AUTHORIZED_KEYS="$KEY" sut
sudo cat .test/.ssh/authorized_keys | grep "$KEY" > /dev/null 2>&1
echo "=> Test passed"