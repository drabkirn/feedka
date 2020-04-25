# Contributing to Drabkirn Rails Base

## Before Submitting an Issue
Check that [our issue database](https://github.com/drabkirn/rails_base/issues)
doesn't already include your problem or suggestion before submitting your issue.
If you find a match, you can use the "subscribe" button to get notified on
updates. Do **NOT** leave random "+1" or "I have this too" comments, as they
only clutter the discussion, and don't help to resolve it. However, if you
have ways to reproduce the issue or have additional information that may help
to resolve the issue, please leave a comment.

## Writing Good Bug Reports and Feature Requests
Please file a single issue per problem and feature request. Do not submit combo issues.

The more information you can provide, the more likely someone will be successful in reproducing the issue and finding a fix. Therefore:
* Provide reproducible steps, what the result of the steps was, and what you would have expected.
* A detailed description of the behavior that you expect.
* Animated GIFs are a tremendous help.
* Version information of your ruby and rails version.
* Error outputs that may exist in your browser console.

## How to Contribute
1. Please add an issue or comment on issues that are open and mention that you are working on it. Then submit a pull request! This will let others know you're working on it.

2. Install the app on your local machine. You need to [Fork](https://help.github.com/articles/fork-a-repo/) this app and then clone it on your local machine. See the Installation section of [README.md](https://github.com/drabkirn/rails_base/blob/master/README.md) on how to do the installation.

3. Set the upstream remote so you can keep your copy of the app synced with the original. To do that, go to your terminal and cd into your cloned Drabkirn Rails Base app directory. Then use one of the following commands:
    * If you have ssh set up with Git
      ```bash
      $ git remote add upstream https://github.com/drabkirn/rails_base.git
      ```
      Or
      ```bash
      git remote add upstream git@github.com:drabkirn/rails_base.git
      ```

4. Before you start working on your issue, create a branch, and name it as the following examples:
    * If its a new feature:
      ```bash
      $ git checkout -b feature/new-feature-name
      ```
    * If its a bug fix
      ```bash
      git checkout -b fix/fixed-bug-name
      ```

5. When you have finished and are ready to submit a Pull Request:
    * Push your branch to your fork
      ```bash
      $ git push origin <your branch name here>
      ```
    * Go to your fork on Github after you have pushed up your branch. A new button should be visible near the top of the page. It will allow you to create a pull request to the original Drabkirn Rails Base repo.
    * You'll see a `PULL_REQUEST_TEMPLATE` - Try to complete this in your own words.
    * Please Link to the issue your pull request resolves in the body of your pull request.

6. **Important:** After you submit your pull request, Drabkirn requires that every contributor sign a Drabkirn Contributor License Agreement (CLA) to a Drabkirn open source project. This Agreement is effective upon your acknowledgment via the CLA Assistant tool. You can read and sign this Agreement at [https://cla-assistant.io/drabkirn/rails_base](https://cla-assistant.io/drabkirn/rails_base) or follow the link in your pull request pending checks list. Until you agree by signing this Agreement, Drabkirn will not merge your pull request.

We're looking forward to accepting your contributions and make this world a better place. Please keep them coming. ❤💖