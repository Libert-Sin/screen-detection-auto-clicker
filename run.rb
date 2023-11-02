#!/bin/ruby

require 'mini_magick'

def capture_screen(filename)
  `import -window root -crop 706x875+1623+2334 #{filename}`
end

def image_changed?(prev_image_path, curr_image_path)
  begin

    result = `compare -metric AE #{prev_image_path} #{curr_image_path} null: 2>&1`.to_f


    prev_image = MiniMagick::Image.open(prev_image_path)
    normalized_difference = result / (prev_image.width * prev_image.height)

    puts "Normalized Difference: #{normalized_difference}"
  rescue => e
    puts "Error comparing images: #{e.message}"
    normalized_difference = Float::INFINITY
  end

  threshold = 0.01
  normalized_difference > threshold
end

if ARGV.include?("-t")
  index = ARGV.index("-t")
  times = ARGV[index + 1].to_i
else
  times = 1
end

if ARGV.include?("-a")
  index = ARGV.index("-a")
  all = ARGV[index + 1].to_i
else
  all = 0
end

sleep(5)
times.times do |current_iteration|
  remaining_times = times - current_iteration
  now_image = all - remaining_times  - 1
  print("now #{now_image} ")

  start_capture = "#{now_image}_start_capture.png"
  end_capture = "#{now_image}_end_capture.png"
  capture_screen(start_capture)

  system("xdotool click 1")
  sleep(1)
  system("xdotool click 1")
  sleep(1)
  system("xdotool click 1")
  sleep(1)

  capture_screen(end_capture)
  puts("left #{remaining_times}")
  if !image_changed?(start_capture, end_capture)
    puts "화면 변경 없음! 중단합니다."
    break
  end


    system("xdotool key space")
  sleep(3)
end
