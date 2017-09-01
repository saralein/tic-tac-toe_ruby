task default: %w[test]

desc 'runs tests'
task :test do
  bundle exec 'rspec'
end

desc 'runs game'
task :play do
  begin
    ruby 'app.rb'
  rescue SignalException
  end
end
