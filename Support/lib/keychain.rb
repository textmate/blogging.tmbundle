# Simple interface for reading and writing Internet passwords to
# the KeyChain.
require "shellwords"

module KeyChain
  class << self
    def add_internet_password(user, proto, host, path, pass)
      %x{security add-internet-password -a #{user.shellescape} -s #{host.shellescape} -r #{proto.shellescape} -p #{path.shellescape} -w #{pass.shellescape}}
    end
    def find_internet_password(user, proto, host, path)
      result = %x{security find-internet-password -g -a #{user.shellescape} -s #{host.shellescape} -p #{path.shellescape} -r #{proto.shellescape} 2>&1 >/dev/null}
      result =~ /^password: "(.*)"$/ ? $1 : nil
    end
  end
end
