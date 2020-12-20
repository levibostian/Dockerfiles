# Fastlane

Docker image that has Fastlane installed as well as a few other utilities:

* git

Used primarily with CircleCi to run Fastlane builds for deploying apps.

Here is an example:

```
version: 2
jobs:
  build:
    working_directory: ~/code
    docker:
      - image: circleci/android:api-26-alpha
    environment:
      JVM_OPTS: -Xmx3200m
    steps:
      - checkout
      - restore_cache:
          key: jars-{{ checksum "build.gradle" }}-{{ checksum  "app/build.gradle" }}
      - run:
          name: Download Dependencies
          command: ./gradlew androidDependencies
      - save_cache:
          paths:
            - ~/.gradle
          key: jars-{{ checksum "build.gradle" }}-{{ checksum  "app/build.gradle" }}
      - run:
          name: Clean project
          command: ./gradlew clean
      - run:
          name: Build app
          command: ./gradlew assembleProductionRelease
      - store_artifacts:
          path: app/build/reports
          destination: reports
      - persist_to_workspace:
          root: ~/code
          paths:
            - app/build/outputs/apk/production/release/app-production-release.apk
            - app/build/outputs/mapping/production/release/mapping.txt
  deploy:
      working_directory: ~/code
      docker:
        - image: levibostian/fastlane
      environment:
        JVM_OPTS: -Xmx3200m
      steps:
        - checkout
        - attach_workspace:
            at: ~/code
        - run:
            name: Run deploy
            command: fastlane play_deploy
workflows:
  version: 2
  build-n-deploy:
    jobs:
      - build:
          filters: # Runs for both branch pushes and tag pushes
            tags:
              only: /.*/
      - deploy:
          requires:
            - build
          filters: # Only runs for tag pushes, not for branches.
            tags:
              only: /.*/
            branches:
              ignore: /.*/
```
