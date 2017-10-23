# Peachdocs - create new target

When you use [Peachdocs](https://peachdocs.org/) for the first time, it requires that you have a site template setup and ready to go. In order to do that, [peach](https://peachdocs.org/) gives you a handy command in order to get up and running: `peach new -target`. This is a Docker image that has peach installed so you don't have to.

```
$> docker run -it -v /path/to/peach/site:/site.peach/ levibostian/peachdocs_new_target:latest
```

If asked to overwrite in current directory, peach *should* (but I cannot guarantee this) create a directory `templates` and put files in there without disturbing anything else in your project.

After done, if you check out `/path/to/peach/site` you should see a directory `templates` with some files/directories in it.

Make sure that also in `/path/to/peach/site` you have your `custom` directory created and configured. If you are not sure how to do this, check out [my wiki page](http://wiki.curiosityio.com/docs/peachdocs/create#configure-site.) on what files to create.

Next, check out [my peachdocs Docker image](https://hub.docker.com/r/levibostian/peachdocs/) to run your newly configured site.

## Author

* Levi Bostian - [GitHub](https://github.com/levibostian), [Twitter](https://twitter.com/levibostian), [Website/blog](http://levibostian.com)

![Levi Bostian image](https://gravatar.com/avatar/22355580305146b21508c74ff6b44bc5?s=250)
