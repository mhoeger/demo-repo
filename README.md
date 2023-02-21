# My Project

hello 

# USING THE TEMPLATE **important**


### Set up CI
Add your pipeline to Buildkite with the following link:
   [![Add to Buildkite](https://buildkite.com/button.svg)](https://buildkite.com/organizations/pachama/pipelines/new)


### Update README
Delete this section once steps above have been completed!

# Development

To start developing you'll need to have [docker](https://www.docker.com/) installed and ready to use. The `Makefile` in this project provides a handful of helper commands to get started - try run `make dev` to spin up the devbox container and attach a shell.

## Make commands

Here's the full list of `make` commands available:

- `make setup` - sets up your environment, you only need to run this once
- `make run` - spins up the devbox
- `make test` - runs your tests in a container
- `make lint` - runs linting in a container
- `make add packages="..."` - installs a pip package and persists it to `requirements.txt`. It's recommended to run this inside the container rather than on your host.
- `make add-test packages="..."` - installs a pip package and persists it to `requirements-test.txt`. It's recommended to run this inside the container rather than on your host.
- `make install-requirements` - installs all existing requirements from `requirements.txt`.
- `make install-requirements-test` - installs all existing requirements-test from `requirements-test.txt`.
- `make lock` - pip-compiles requirements.in and requirements-test.in

You can always run `make help` to see a list of these commands.

## VSCode

If VSCode is your weapon of choice we've included a handful of things that make your development experience even better.

This project is set up to let VSCode attach to a docker container (the devbox) for a seamless development experience. You'll need to install the [Remote Development](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.vscode-remote-extensionpack) and can read more about [Developing inside containers](https://code.visualstudio.com/docs/remote/containers).

Once this is installed, any time you open the project in VSCode you'll be prompted to "Run in a container" - which you can choose to if you wish.

If you're missing the recommended extensions (i.e. Pylance) then VSCode will also prompt you to install them for the best experience.
