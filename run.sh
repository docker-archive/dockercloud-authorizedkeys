#!/bin/sh
if [ "${AUTHORIZED_KEYS}" != "**None**" ]; then
    echo "=> Found authorized keys"
    mkdir -p /user/.ssh
    chmod 700 /user/.ssh
    touch /user/.ssh/authorized_keys
    chmod 600 /user/.ssh/authorized_keys
    IFS=$'\n'
    arr=$(echo ${AUTHORIZED_KEYS} | tr "," "\n")
    for x in $arr
    do
        x=$(echo $x | sed -e 's/^ *//' -e 's/ *$//')
        cat /user/.ssh/authorized_keys | grep "$x" >/dev/null 2>&1
        if [ $? -ne 0 ]; then
            echo "=> Adding public key to .ssh/authorized_keys: $x"
            echo "$x" >> /user/.ssh/authorized_keys
        fi
    done
else
    echo "ERROR: No authorized keys found in \$AUTHORIZED_KEYS"
    exit 1
fi

if [ "${HARDEN_SECURITY}" ]; then
  sed -i 's/PermitRootLogin yes/PermitRootLogin  without-password/' /etc/ssh/sshd_config
  service ssh restart
fi
