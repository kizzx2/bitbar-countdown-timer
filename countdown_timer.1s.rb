#!/usr/bin/ruby
# <bitbar.title>Countdown Timer</bitbar.title>
# <bitbar.version>v1.0</bitbar.version>
# <bitbar.author>Chris Yuen</bitbar.author>
# <bitbar.author.github>kizzx2</bitbar.author.github>
# <bitbar.desc>Simple countdown timer. Set the time by calling the script from terminal.</bitbar.desc>
# <bitbar.image>http://www.hosted-somewhere/pluginimage</bitbar.image>
# <bitbar.dependencies>ruby</bitbar.dependencies>
# <bitbar.image>https://raw.githubusercontent.com/kizzx2/bitbar-countdown-timer/master/screenshot.png</bitbar.image>
# <bitbar.abouturl>http://github.com/kizzx2/bitbar-countdown-timer</bitbar.abouturl>

fn = File.join(File.dirname($0), '.countdown')

if ARGV.count == 0
  task = nil

  if File.file?(fn)
    lines = File.read(fn).lines

    time = Time.at(lines.first.to_i)
    task = lines[1] if lines.count > 1
  else
    time = Time.at(0)
  end

  remain = time - Time.now
  remain = 0 if remain < 0

  color = nil

  if remain < 15 * 60 && remain != 0
    color = "red"
  elsif remain < 30 * 60 && remain != 0
    color = "orange"
  end

  h = (remain / 3600).to_i
  remain -= h * 3600

  m = (remain / 60).to_i
  remain -= m * 60

  s = remain

  str = ""
  str << "#{task}: " if task
  str << "%02i:%02i:%02i" % [h, m, s]
  str << "| color=#{color}" if color

  puts str
else

  arg = ARGV.shift || ''
  time = 0

  if weeks = arg.scan(/\d+w/)[0]
    time += weeks.rstrip.to_i * (7 * 24 * 60 * 60)
  end

  if days = arg.scan(/\d+d/)[0]
    time += days.rstrip.to_i * (24 * 60 * 60)
  end

  if hours = arg.scan(/\d+h/)[0]
    time += hours.rstrip.to_i * (60 * 60)
  end

  if minutes = arg.scan(/\d+m/)[0]
    time += minutes.rstrip.to_i * 60
  end

  if seconds = arg.scan(/\d+s/)[0] || arg.scan(/\d+$/)[0]
    time += seconds.rstrip.to_i
  end

  time += Time.now.to_i if time > 0

  abort "Error: Invalid argument '#{arg}'" if arg !~ /^(\d+[smhdw]?)+$/

  str = ""
  str << time.to_i.to_s

  if ARGV.count > 1
    str << "\n"
    str << ARGV.drop(1).join(' ')
  end

  File.write(fn, str)
end
