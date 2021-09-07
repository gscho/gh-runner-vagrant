# gh-runner-vagrant

## Description

This repo contains a `Vagrantfile` that will create and provision an Ubuntu 20.04 virtual machine and provision it with a self-hosted GitHub Action Runner.

## Use Cases

- Troubleshooting actions locally
- Testing the OS configuration of a runner locally (eg: using ansible or chef, etc.)
- Playing around with self-hosted runners

## Instructions

Install `vagrant` and `virtualbox`.

Eg: using [homebrew](https://brew.sh)

	$ brew install vagrant
	$ brew install cask virtualbox


### Add a self-hosted runner

1. Create a `.env` file (see `env.example` for an example)
2. Add at minimum the `$SCOPE` and `$PAT` variables
3. Source `.env`
4. Run `vagrant up --provision`

### Remove a self-hosted runner

1. Run `vagrant destroy`. This will automatically deregister the runner from GitHub if your `$SCOPE` and `$PAT` variables are set properly.