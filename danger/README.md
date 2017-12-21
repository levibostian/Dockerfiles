# Danger

**Alpine** image that has [Danger](http://danger.systems/) installed. 

## Use

Danger requires a few environment variables in order to run successfully. So, I use Docker compose to make this easy to set for myself. 

```
version: '2'
services:
  danger:
    image: "levibostian/danger"
    volumes:
      - .:/danger
    environment:
      - DANGER_GITHUB_API_TOKEN
      - HAS_JOSH_K_SEAL_OF_APPROVAL
      - TRAVIS_PULL_REQUEST
      - TRAVIS_REPO_SLUG
```

Store this file in same directory as your `Dangerfile`. This compose file will work for all projects on the Travis CI service. Each CI server requires different environment variables. To find the variables to set for your CI, [check out danger's directory of all supported CI sources](https://github.com/danger/danger/tree/master/lib/danger/ci_source), select the CI service you use, then you will see environment variables set in `validates_as_ci?` and `validates_as_pr?` functions. You will need to put all of those environment variables in your docker compose file. 
