#!/usr/bin/env ruby

require 'socket'

RC_ERR_SOCKET_EXISTS=10
SOCKET_PATH = '/tmp/Centos57_com1'

# Socket needs to be created before thread spawns to prevent VirtualBox from failing to connect

if File.exists?(SOCKET_PATH)
	puts "Sorry, the socket #{SOCKET_PATH} already exists."
	puts "Remove if it is not currently in use by another instance of this script."
	exit RC_ERR_SOCKET_EXISTS
end

socket_session = UNIXServer.open(SOCKET_PATH)

thread = Thread.new do
	shutdown_called = false
	# accept should block until VirtualBox is started and initiates the Com port pipe.
	socket = socket_session.accept
	puts "Connection Accepted"
	console_line = ""
	while(!socket.eof? && partial = socket.readpartial(82)) do
		if partial == "\n"
			console_line = ""
		else
			console_line += partial
		end

		# TODO: cuz this is going to scale well...
		if console_line.match /Press any key to continue.$/
			socket.puts ""
		end

		# TODO: need to anchor on something better than this...
		if console_line.match /login:$/
			puts "Logging in as root."
			socket.puts "root"
		end

		if console_line.match /Password:$/
			socket.puts "vagrant"
		end

		if !shutdown_called && !console_line.match(/\# $/).nil?
			puts "Shutdown initiated."
			shutdown_called = true
			socket.puts "shutdown -h now"
		end
	end
	socket.close
end

`/usr/bin/VBoxManage startvm Centos5.7`

thread.join

File.delete(SOCKET_PATH)

