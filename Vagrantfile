# frozen_string_literal: true

Vagrant.configure('2') do |config|
  if RUBY_PLATFORM.include? "arm64" and RUBY_PLATFORM.include? "darwin"
    config.vm.box = 'utm/bookworm'
  else
    config.vm.box = 'debian/bookworm64'
  end

  config.vm.provision 'ansible' do |ansible|
    ansible.playbook = 'site.yml'
    ansible.host_vars = {
      'default' => {
        hostname: 'supernode-vagrant',
      },
    }
    ansible.groups = {
      'vagrant' => ['default']
    }
  end

  config.vm.synced_folder ".", "/vagrant", disabled: true
end
