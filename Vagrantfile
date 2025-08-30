# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # Box base Fedora (usar versão estável mais recente)
  config.vm.box = "fedora/41-cloud-base"

  # Nome da VM
  config.vm.hostname = "fedora-nord"

  # Rede (opcional, NAT por padrão)
  config.vm.network "forwarded_port", guest: 8080, host: 8080

  # Provisionamento via shell
  config.vm.provision "shell", inline: <<-SHELL
    echo "🚀 Provisionando Fedora Nord Setup..."

    # Atualizar sistema
    sudo dnf update -y

    # Criar diretório temporário
    mkdir -p ~/Temp
    cd ~/Temp

    # Baixar o script de setup
    if [ ! -f "fedora-nord-setup.sh" ]; then
      wget -O ~/Temp/fedora-nord-setup.sh https://raw.githubusercontent.com/SEU_USUARIO/SEU_REPOSITORIO/main/fedora-nord-setup.sh
      chmod +x ~/Temp/fedora-nord-setup.sh
    fi

    # Executar o script
    ~/Temp/fedora-nord-setup.sh
  SHELL

  # Opcional: aumentar memória e CPUs
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "4096"
    vb.cpus = 2
  end
end
