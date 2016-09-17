worker_processes 1
preload_app true
listen "127.0.0.1:8080"
path = '/home/isucon/private_isu/webapp/ruby/'
stderr_path path + "/log/stderr.log"
stdout_path path + "/log/stdout.log"
