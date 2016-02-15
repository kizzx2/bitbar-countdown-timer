#!/usr/bin/ruby
# <bitbar.title>Countdown Timer</bitbar.title>
# <bitbar.version>v1.0</bitbar.version>
# <bitbar.author>Chris Yuen</bitbar.author>
# <bitbar.author.github>kizzx2</bitbar.author.github>
# <bitbar.desc>Simple countdown timer</bitbar.desc>
# <bitbar.image>http://www.hosted-somewhere/pluginimage</bitbar.image>
# <bitbar.dependencies>ruby</bitbar.dependencies>
# <bitbar.image>https://raw.githubusercontent.com/kizzx2/bitbar-countdown-timer/master/screenshot.png</bitbar.image>
# <bitbar.abouturl>http://github.com/kizzx2/bitbar-countdown-timer</bitbar.abouturl>

fn = File.join(File.dirname($0), '.countdown')

if ARGV.count == 0
  if File.file?(fn)
    time = Time.at(File.read(fn).to_i)
  else
    time = Time.at(0)
  end

  remain = time - Time.now
  remain = 0 if remain < 0

  color = nil

  if remain < 15 * 60
    color = "red"
  elsif remain < 30 * 60
    color = "orange"
  end

  h = (remain / 3600).to_i
  remain -= h * 3600

  m = (remain / 60).to_i
  remain -= m * 60

  s = remain

  str = "%02i:%02i:%02i" % [h, m, s]
  str << "| color=#{color}" if color

  puts str
else
  case ARGV.first
  when /^(\d+)s$/
    time = Time.now + $1.to_i
  when /^(\d+)m$/
    time = Time.now + $1.to_i * 60
  when /^(\d+)h$/
    time = Time.now + $1.to_i * 3600
  else
    puts "Error: Invalid argument '#{ARGV.first}'"
    exit 1
  end

  File.write(fn, time.to_i)
end


