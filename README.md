# Dockerfiles

Collection of Dockerfiles I have created to create images from. 

# Collection

# debian10-ansible-testing

Debian 10 image with systemd enabled and root SSH login with SSH key. This image is designed for testing Ansible roles. The image is meant to be as close as possible to a brand new server created using a service like DigitalOcean or Linode where you can login to the server with a SSH key injected into the server OS by the service. 

This image does require some special instructions to get it working. To run it, it requires some arguments:

```
docker run -p 2222:22 -e SSH_KEY="$(cat ~/.ssh/id_rsa.pub)" --detach --privileged --volume=/sys/fs/cgroup:/sys/fs/cgroup:ro levibostian/debian10-ansible-testing:latest
```

If using Ansible Molecule for testing, this is how you will setup your `molecule.yml` config file:

```yml
driver:
  name: docker
platforms: # Options: https://github.com/ansible-community/molecule-docker/blob/bff4fde7a4b6f6d9b1f35be3b461b64b6b904252/molecule_docker/driver.py#L56
  - name: instance
    image: "levibostian/debian10-ansible-testing:latest"
    command: "" # If do not set this, molecule will run `bash -c "while true; do sleep 10000; done"` and ignore the docker container's CMD. 
    volumes:
      - /sys/fs/cgroup:/sys/fs/cgroup:ro
    privileged: true
    pre_build_image: true
    env: 
      SSH_KEY: "$SSH_KEY"
    published_ports:
      # Allowing to ssh into container. Map the host machine to the container's port 22
      - 0.0.0.0:2222:22/udp
      - 0.0.0.0:2222:22/tcp
```

Then, run the molecule tests with: `SSH_KEY=$(cat ~/.ssh/id_rsa.pub) molecule test`

## pgdump-s3

Run `pg_dump` to create a backup of a Postgres database and upload the dump to a S3 bucket. 

# Deprecated 

There are many docker images that I have created in the past but I personally no longer have a purpose for these images. When this happens, I no longer maintain a built and updated Docker image for it. I do, however, keep the `Dockerfile` around for reference for anyone to use 😄. 