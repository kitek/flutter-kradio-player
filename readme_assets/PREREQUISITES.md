# Prerequisites

This document describes basic information about the process and the required configuration.

## The process

We can divide the process into three different workflows:
- checks executed after creating pull request
- release the test applications for android and iOS after merge into develop branch
- release the production applications for android and iOS after merge into master branch

## Github actions

GitHub Actions makes it easy to automate all your software workflows,
now with world-class CI/CD. Build, test, and deploy your code right
from GitHub. Make code reviews, branch management, and issue triaging
work the way you want.

## Test configuration locally

Many of continuous integration and delivery tools have an issue with testing configuration locally.
It's really annoying pushing your config to test or validate it remotely.
Github actions can be tested locally with a tool called [act](https://github.com/nektos/act).  

When you run act it reads in your GitHub Actions from `.github/workflows/` and determines the set of actions that need to be run.
It uses the Docker API to either pull or build the necessary images,
as defined in your workflow files and finally determines the execution path based on the dependencies that were defined.

To install with Homebrew, run:

>brew install nektos/tap/act

This repository contains settings for [act](https://github.com/nektos/act) placed in [.actrc](/.actrc) file which defines:

- runner image: `mingc/android-build-box:latest` - an optimized docker image includes Android, Kotlin, Flutter sdk. This image is >5GB so it might take a while on the first run to download it.
- secret-file: `.env` - contains all secrets added on Github.
It's not included in this repository, you should change name of `.env-example` and fill it with your values.
Check Secrets section below for more details.

To run Github actions pull request flow execute command:
> act pull_request

To run Github actions triggered on a push to develop execute command:
> act

## Versioning

Mobile apps are using a versioning system compound with two values:

`versionCode` - a positive integer used as an internal version number.
This number is used only to determine whether one version is more recent than another,
with higher numbers indicating more recent versions.

In our setup for the `versionCode` we use `${GITHUB_RUN_NUMBER}` which is a unique number for each run of a particular workflow in a repository.
This number begins at 1 for the workflow's first run, and increments with each new run. This number does not change if you re-run the workflow run.
More about Github environment variables you can find [here](https://help.github.com/en/actions/configuring-and-managing-workflows/using-environment-variables).

`versionName` - a string used as the version number shown to users. This setting can be specified as a raw string or as a reference to a string resource.

In our case for the `versionName` we use the value from the file [version-name.properties](/version-name.properties) which should be manually updated on every release.
>versionName=1.0.0

## Signing, secrets, envs

Both android and iOS app requires signing before releasing.
For applications with open source, it's always a challenge of how and where to store keys and credentials.

Sensitive data can be stored as [Secrets](https://help.github.com/en/actions/configuring-and-managing-workflows/creating-and-storing-encrypted-secrets) - encrypted environment variables that you create in a repository or organization.
Secrets are limited to 64 KB in size - that gives us the ability to store the whole key stores and files required by firebase (google-services.json and GoogleService-Info.plist).
To store file content as a secret first we have to encode the content with base64:

> openssl base64 -in infile -out outfile

### Common

**FIREBASE_TOKEN**

Token required to deploy test applications with Firebase App Distribution.
You can acquire it by installing [firebase tools](https://firebase.google.com/docs/cli) and run:
>firebase login:ci

### Android

**ANDROID_GOOGLE_SERVICES_FILE**

Contains base64 encoded google-services.json file.
Firebase manages all of your API settings and credentials through this configuration file.
For a library or open-source sample we do not include the JSON file
because the intention is that users insert their own to point the code to their own backend.

**ANDROID_KEYSTORE_FILE**

Contains base64 encoded release.jks file.
You should create this file by your own - [more info](https://developer.android.com/studio/publish/app-signing#generate-key).
During the release process, this file is recreated in the `.signing/release.jks` path.
More details can be found in signing configuration placed in [signing.gradle](/android/signing.gradle).

**ANDROID_KEYSTORE_ALIAS**

Contains keystore alias value.

**ANDROID_KEYSTORE_PASSWORD**

Contains keystore password value.

### iOS
