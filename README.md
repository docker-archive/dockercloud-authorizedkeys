# authorizedkeys

[![Deploy to Docker Cloud](https://files.cloud.docker.com/images/deploy-to-dockercloud.svg)](https://cloud.docker.com/stack/deploy/)

Adds a user public SSH key to the host's `~/.ssh/authorized_keys` using a container

## Usage

    docker run -v /root:/user -e AUTHORIZED_KEYS="`cat ~/.ssh/id_rsa.pub`" dockercloud/authorizedkeys

With multiple keys:

	docker run -v /root:/user -e AUTHORIZED_KEYS="`cat ~/.ssh/id_rsa1.pub`,`cat ~/.ssh/id_rsa2.pub`" dockercloud/authorizedkeys

Adding the key to a user different than `root`:

	docker run -v /home/myuser:/user -e AUTHORIZED_KEYS="`cat ~/.ssh/id_rsa.pub`" dockercloud/authorizedkeys


## Usage in Docker Cloud

We recommend using this image in Docker Cloud as follows:

	authorizedkeys:
	  image: dockercloud/authorizedkeys
	  deployment_strategy: every_node
	  autodestroy: always
	  environment:
	    - AUTHORIZED_KEYS=ssh-rsa AAAAB3NzaC1y....
	  volumes:
	    - /root:/user:rw
