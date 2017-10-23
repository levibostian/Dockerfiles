# Peachdocs

Runs a [Peachdocs](https://peachdocs.org/) web server.

To get web server up and running:

* Create a directory on your local machine where all of the peachdocs files will be stored.

```
$> mkdir peachdocs_site
```

* Check out [my Docker image for creating a new Peachdocs target site](https://hub.docker.com/r/levibostian/peachdocs_new_target/).

* Create `custom` directory that contains your configuration files. Check out [my wiki page](http://wiki.curiosityio.com/docs/peachdocs/create#configure-site.) on how to do this.

* You should now the following in your `peachdocs_site` directory:

```
templates/
custom/app.ini
```

* Time to run peachdocs:

```
$> docker run -p 5555:5555 -v /path/to/site/peachdocs_site:/site.peach/ levibostian/peachdocs:latest
```

## Author

* Levi Bostian - [GitHub](https://github.com/levibostian), [Twitter](https://twitter.com/levibostian), [Website/blog](http://levibostian.com)

![Levi Bostian image](https://gravatar.com/avatar/22355580305146b21508c74ff6b44bc5?s=250)
