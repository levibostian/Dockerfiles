# Peachdocs

Runs a [Peachdocs](https://peachdocs.org/) web server.

To get web server up and running:

* Create a directory on your local machine where all of the peachdocs files will be stored.

```
$> mkdir peachdocs_site
```

* Check out [my Docker image for creating a new Peachdocs target site](https://hub.docker.com/r/levibostian/peachdocs_new_target/).

* Create `custom` directory that contains your configuration files. Check out [my wiki page](http://wiki.curiosityio.com/docs/peachdocs/create#configure-site.) on how to do this. *Note: Your app.ini file must contain and use the port 5555 or your site will not be hosted. The Dockerfile here exposes port 5555.*

* You should now the following in your `peachdocs_site` directory:

```
templates/
custom/app.ini
```

* Time to run peachdocs:

```
$> docker run -p 5555:5555 -v /path/to/site/peachdocs_site:/site.peach/ levibostian/peachdocs:latest
```

## Example docker-compose file

```
version: '2'
services:
  peach:
    image: "levibostian/peachdocs:latest"
    container_name: peach
    restart: always
    expose:
      - "5555"
    environment:
      - VIRTUAL_HOST=peach.levibostian.com
      - LETSENCRYPT_HOST=peach.levibostian.com
      - LETSENCRYPT_EMAIL=levi@curiosityio.com
    volumes:
      - /home/core/peach.site:/site.peach/

networks:
  default:
    external:
      name: nginx-proxy-network
```

Combine that with a nginx-proxy and lets-encrypt docker compose and you have a https peach hosted site:

```
version: '2'
services:
  nginx-proxy:
    image: jwilder/nginx-proxy
    container_name: nginx-proxy
    restart: always
    ports:
      - "80:80"
      - "443:443"
    labels:
      - "com.github.jrcs.letsencrypt_nginx_proxy_companion.nginx_proxy"
    volumes:
      - /var/run/docker.sock:/tmp/docker.sock:ro
      - /usr/share/nginx/html
      - /etc/nginx/vhost.d
      - /etc/docker/nginx-proxy/ssl:/etc/nginx/certs:ro
  lets-encrypt-nginx-proxy-companion:
    image: jrcs/letsencrypt-nginx-proxy-companion
    container_name: lets-encrypt-nginx-proxy-companion
    volumes_from:
      - nginx-proxy
    volumes:
      - /etc/docker/nginx-proxy/ssl:/etc/nginx/certs:rw
      - /var/run/docker.sock:/var/run/docker.sock:ro

networks:
  default:
    external:
      name: nginx-proxy-network
```

## Author

* Levi Bostian - [GitHub](https://github.com/levibostian), [Twitter](https://twitter.com/levibostian), [Website/blog](http://levibostian.com)

![Levi Bostian image](https://gravatar.com/avatar/22355580305146b21508c74ff6b44bc5?s=250)
