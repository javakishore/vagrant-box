#!/usr/bin/env ruby
# vagrant development environment

# read settings file
require "yaml"
cd = File.dirname(__FILE__)
settings = YAML.load_file("#{cd}/provision/settings.yaml")

# check for requried plugins
settings["plugins"].each do |plugin|
  unless Vagrant.has_plugin?(plugin)
    raise %{
      Missing vagrant plugin #{plugin}!
      Install it by running: vagrant plugin install #{plugin}
    }
  end
end unless settings["plugins"].nil? || settings["plugins"].empty?


Vagrant.configure(2) do |config|

  # virtual box settings
  config.vm.box = settings["box"]
  config.vm.hostname = settings["hostname"]
  config.vm.provider :virtualbox do |vb|
    vb.name = settings["name"]
    vb.memory = settings["memory"]
    vb.cpus = settings["cpus"]
  end

  # synchronise repo with /vagrant
  config.vm.synced_folder ".", "/vagrant", type: "virtualbox"

  # forward ports
  settings["ports"].each do |port|
    split = port.split(':')
    config.vm.network :forwarded_port, host: split[0], guest: split[1]
  end unless settings["ports"].nil? || settings["ports"].empty?


end
