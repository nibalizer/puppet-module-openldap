#!/usr/bin/env ruby

filename = ARGV[0]
ip_addr = ARGV[1]

ssh_opts = '-o VerifyHostKeyDNS=no -o StrictHostKeyChecking=no'

testfile = File.read(filename)

commands = []
testfile.each_line do |line|
  if line.start_with?('#!')
    commands << line.strip.sub(/^#!/, '')
  end
end

commands.each do |line|
  puts "Running test: #{line}"
  results = `ssh #{ssh_opts} root@#{ip_addr} '#{line}'`
  if $?.to_i != 0
    abort("Tests failed on #{line}")
  end
end

