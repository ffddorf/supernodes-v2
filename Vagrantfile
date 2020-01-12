# frozen_string_literal: true

Vagrant.configure('2') do |config|
  config.vm.box = 'debian/buster64'

  config.vm.provision 'ansible' do |ansible|
    ansible.playbook = 'site.yml'
    ansible.host_vars = {
      'default' => {
        hostname: 'supernode-vagrant',
        primary_ipv4_address: '172.16.0.1/32',
      },
    }
  end
end
