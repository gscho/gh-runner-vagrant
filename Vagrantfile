# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = 4096
    vb.cpus = 3
  end

  config.vm.provision "shell", inline: "sudo apt-get update -y && sudo apt-get install -y jq && sudo rm -rf ./runner"
  
  args = "-s #{ENV['SCOPE']}"
  args << " -g #{ENV['GHE_HOSTNAME']}" if ENV['GHE_HOSTNAME']
  args << " -n #{ENV['RUNNER_NAME']}" if ENV['RUNNER_NAME']
  args << " -u #{ENV['RUNNER_USER']}" if ENV['RUNNER_USER']
  args << " -l #{ENV['RUNNER_LABELS']}" if ENV['RUNNER_LABELS']

  config.vm.provision("shell", 
    privileged: false, 
    path: "https://raw.githubusercontent.com/actions/runner/main/scripts/create-latest-svc.sh",
    env: { RUNNER_CFG_PAT: ENV['PAT'] }) do |s|
    s.args = args
  end

  env_args = { RUNNER_CFG_PAT: ENV['PAT'], SCOPE: ENV['SCOPE'] }
  env_args[:GHE_HOSTNAME] = ENV['GHE_HOSTNAME'] if ENV['GHE_HOSTNAME']

  config.trigger.before :destroy do |trigger|
    trigger.warn = "Removing runner from GitHub Server"
    trigger.run_remote = { privileged: false, path: "remove-runner.sh", env: env_args }
  end
end
