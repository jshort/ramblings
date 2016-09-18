require 'socket' # Provides TCPServer and TCPSocket classes

MAX_CONN_COUNT = ENV['THREADS'] ? ENV['THREADS'].to_i : 2

def running_thread_count
  Thread.list.select {|thread| thread.status == 'run'}.count
end

Thread.current[:name] = :main

#start the server thread
server_thread = Thread.start do
  Thread.current[:name] = :server

  # Initialize a TCPServer object that will listen
  # on localhost:2345 for incoming connections.
  server = TCPServer.new('localhost', 2345)
  sync = Mutex.new
  cum_conn_count = 0
  conn_count = 0
  open_sockets = []

  loop do
    # puts "PrePre: Open connetions = #{conn_count}"
    if conn_count < MAX_CONN_COUNT
      conn_count += 1
      if conn_count % 5 == 0; puts "#{conn_count} connections."; end

      # use a separate thread, accepting multiple incoming connections
      Thread.start(server.accept) do |socket|
        # puts "Pre: Open connections = #{conn_count}"
        open_sockets << socket
        # puts "Server connection number #{sync.synchronize {cum_conn_count += 1}} initiated, socket: #{socket.inspect}"
        Thread.current[:name] = "Thread for conn #{cum_conn_count}"
        # puts "Open connections = #{conn_count}"
        # sleep 1
        # puts "Done sleeping"

        # Read the first line of the request (the Request-Line)
        request = socket.gets
        # puts request

        response = "Hello World!\n"

        # We need to include the Content-Type and Content-Length headers
        # to let the client know the size and type of data
        # contained in the response. Note that HTTP is whitespace
        # sensitive, and expects each header line to end with CRLF (i.e. "\r\n")
        socket.print "HTTP/1.1 200 OK\r\n" +
                     "Content-Type: text/plain\r\n" +
                     "Content-Length: #{response.bytesize}\r\n" +
                     "Connection: close\r\n"

        # Print a blank line to separate the header from the response body,
        # as required by the protocol.
        socket.print "\r\n"

        # Print the actual response body, which is just "Hello World!\n"
        socket.print response

        # Close the socket, terminating the connection
        socket.close
        conn_count -= 1
        open_sockets.delete socket
      end
    else
      puts 'Hit max open sockets'
      sleep 1
    end
  end
end

spam_thread = Thread.start do
  Thread.current[:name] = :spam
  50.times do |i|
    puts '*' * 50
    puts "Spam thread, #{i} times"
    puts 'Threads:'
    Thread.list.each {|t| puts "#{t.inspect}: #{t[:name]}" }
    puts '*' * 50
    sleep 10
  end
end

server_thread.join
# puts 'In between'
# spam_thread.join
