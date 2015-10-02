#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
#
# simple simple*2 createtags-ruby
# ===================================
# github: https://github.com/ikeikeikeike/home/tree/develop/bin
#
# .. code-block:: bash
#
# **Usage**
#
# add rvm packages (default django) ::
#
#     $ createtags-ruby -p fluentd mongo
#
# add standard packages ::
#
#     $ createtags-ruby -s SocketServer commands
#
# not include the rvm ::
#
#     $ createtags-ruby --no-rvm
#
# createtags-ruby script produce more command function.
#
# Help ::
#
#     $ createtags-ruby --help
#     usage: createtags-ruby [-h] [-a] [-p PACKAGES [PACKAGES ...]]
#                              [-s STANDARD_PACKAGES [STANDARD_PACKAGES ...]]
#                              [--no-rvm] [--allow-testcode] [-v]
#                              [path]
#
#     ctags util for rvm.
#
#     positional arguments:
#      # path                  project path.
#
#     optional arguments:
#       -h, --help            show this help message and exit
#       -a, --all             all in rvm packages. ignore all options.
#       -p PACKAGES [PACKAGES ...], --packages PACKAGES [PACKAGES ...]
#                             give packages name. default is a `django` package.
#       -s STANDARD_PACKAGES [STANDARD_PACKAGES ...], --standard-packages STANDARD_PACKAGES [STANDARD_PACKAGES ...]
#                             give packages name. for the standard library.
#       --no-rvm       not include the rvm.
#       --allow-testcode      include the test code.
#       -v, --version         show program's version number and exit
#
# :copyright: Tatsuo Ikeda
# :license: None
# ===================================
# :create_date: 2012-04-05T14:16:14

require 'optparse'

def rmtag(path)
  begin
  rescue
  end
end

def getvepath
  res = `rvm gemdir`
  File.join(res.chomp, "gems")
end

def runcmd(cmd)
  STDOUT.write "Run ::\n #{cmd}\n"
  p `#{cmd}`
end

def main(args)

  # options
  exclude_option = "--languages=ruby " #--ruby-kinds=-i-v "
  # if not args.allow_testcode:
    # exclude_option += (
      # "--exclude=spectest_* "
      # "--exclude=tests.py "
      # "--exclude=test.py "
      # "--exclude=*/IPython/* "
      # "--exclude=*/unittest/* "
      # "--exclude=*/testing/* "
      # "--exclude=*/testsuite/* "
      # "--exclude=*/test/* "
      # "--exclude=*/tests/*")
  # current path
  runcmd("ctags -f ~/rtags -R #{exclude_option} #{args[:path]}")

  # gemdirs
  if args.include?(:spackages) then
    gemdir = getvepath
    args[:spackages].each do |path|
      runcmd("ctags -f ~/rtags -R -a #{File.join(gemdir, "#{path}*", "lib", "*")}")
    end
  end
end


if __FILE__ == $0

  args = {
    :path => Dir.pwd
  }
  opt = OptionParser.new
  opt.on('--path PATH', 'Path to target directory') {|v| args[:path] = v}
  opt.on('-a', '--all', 'all in rvm packages. ignore all options.') {|v| args[:all] = v}
  opt.on('-p', '--packages PACKAGES', 'give packages name. default is a `rails` package.') {|v| args[:packages] = v}
  opt.on('-s', '--standard-packages P1,P2,,', 'give packages name. for the standard library.') {|v| args[:spackages] = v.split(",")}
  opt.on('--[no-]rvm', 'not include the rvm.') {|v| args[:rvm] = v}
  opt.on('--allow-testcode', 'include the test code.') {|v| args[:testcode] = v}
  opt.version = '0.5.2'
  opt.parse(ARGV)

  main args
end


#  vim: set et fenc=utf-8 ft=ruby ff=unix sts=2 sw=2 ts=2 :
