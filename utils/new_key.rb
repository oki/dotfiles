#!/usr/local/bin/ruby

require 'rubygems'
require 'net/ssh'

print "User: "
user = gets.chomp!

print "Password: "
password = gets.chomp!

print "Host: "
host = gets.chomp!

print "Port: "
port = gets.chomp!

puts "Checking host..."

opts = { :password => password }
if port.to_i > 0
    opts[:port] = port
end

Net::SSH.start(host, user, opts) do |ssh|
    result = ssh.exec!('ls')
    puts result

    # polaczony, tworzymy klucze
    puts "[+] Generating key for #{user}@#{host}"
    %x(ssh-keygen -t dsa -f #{host})

    pub_key  = "#{host}.pub"
    priv_key = host

    if !File.exists?(priv_key)
        raise "Nie utworzono klucza prywatnego"
    end
    if !File.exists?(pub_key)
        raise "Nie utworzono klucza publicznego"
    end

    pub_key_data = IO.read(pub_key)

    # %x(mv #{priv_key} $HOME/.ssh/)
    # %x(mv #{pub_key} $HOME/.ssh/)

    puts pub_key_data.class

    ssh.exec!('[ -d "$HOME/.ssh" ] || (echo "Nie ma katalogu ~/.ssh - tworze"; mkdir $HOME/.ssh; chmod 700 $HOME/.ssh)')
    ssh.exec!("echo -n \"#{pub_key_data}\" >> $HOME/.ssh/authorized_keys && chmod 600 $HOME/.ssh/authorized_keys")

    ssh_config = "#{ENV['HOME']}/.ssh/config"

    puts "[+] Dopisuje do konfiga"
    File.open(ssh_config, 'a') do |file|
        file.puts 
        file.puts "# Automatic added at #{Time.now}"
        file.puts "Host #{host}"
        file.puts "User #{user}"
        if port.to_i > 0
            file.puts "Port #{port}"
        end
        file.puts "IdentityFile ~/.ssh/#{host}"
    end

    puts "[+] Done"
    puts "[+] ssh #{user}@#{host}"
end
