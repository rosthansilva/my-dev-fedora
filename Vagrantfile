# -*- mode: ruby -*-
# vi: set ft=ruby :

# Usuário a ser criado na VM
USERNAME = "rosthan"

Vagrant.configure("2") do |config|
  # Box base Fedora
  config.vm.box = "fedora/41-cloud-base"

  # Nome da VM
  config.vm.hostname = "fedora-nord"

  # Rede (opcional)
  config.vm.network "forwarded_port", guest: 8080, host: 8080

  # Mantém login SSH como vagrant (chaves funcionais)
  config.ssh.username = "vagrant"
  config.ssh.insert_key = true

  # Provisionamento root (instalar wget antes de usar rosthan)
  config.vm.provision "shell", privileged: true, inline: <<-SHELL
    echo "🚀 Provisionando Fedora Nord Setup..."

    # Atualizar sistema
    dnf update -y

    # Instalar wget se não existir
    dnf install -y wget git curl unzip tar

    # Criar usuário se não existir
    if ! id -u #{USERNAME} >/dev/null 2>&1; then
      useradd -m -s /bin/bash #{USERNAME}
      echo "#{USERNAME}:vagrant" | chpasswd
      usermod -aG wheel #{USERNAME}
      echo "#{USERNAME} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/#{USERNAME}
      chmod 440 /etc/sudoers.d/#{USERNAME}

      # Configurar SSH
      mkdir -p /home/#{USERNAME}/.ssh
      cp /home/vagrant/.ssh/authorized_keys /home/#{USERNAME}/.ssh/authorized_keys
      chown -R #{USERNAME}:#{USERNAME} /home/#{USERNAME}/.ssh
      chmod 700 /home/#{USERNAME}/.ssh
      chmod 600 /home/#{USERNAME}/.ssh/authorized_keys
    fi
  SHELL

  # Provisionamento como rosthan sem sudo
  config.vm.provision "shell", privileged: false, inline: <<-SHELL
    echo "👤 Executando setup como #{USERNAME}..."

    # Criar diretório temporário
    mkdir -p ~/Temp
    cd ~/Temp

    # Baixar script de setup
    if [ ! -f "fedora-nord-setup.sh" ]; then
      wget -O ~/Temp/fedora-nord-setup.sh https://raw.githubusercontent.com/rosthansilva/my-dev-fedora/refs/heads/main/fedora-nord-setup.sh
      chmod +x ~/Temp/fedora-nord-setup.sh
    fi

    # Executar o script
    bash ~/Temp/fedora-nord-setup.sh
  SHELL

  # Configuração de recursos da VM
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "4096"
    vb.cpus = 2
  end
end
