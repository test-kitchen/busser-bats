Then(/^the vendor directory named "(.*?)" should exist$/) do |name|
  directory = File.join(ENV['BUSSER_ROOT'], "vendor", name)
  check_directory_presence([directory], true)
end

Then(/^the vendor directory named "(.*?)" should not exist$/) do |name|
  directory = File.join(ENV['BUSSER_ROOT'], "vendor", name)
  check_directory_presence([directory], false)
end

Then(/^the vendor file "(.*?)" should contain "(.*?)"$/) do |file, content|
  file_name = File.join(ENV['BUSSER_ROOT'], "vendor", file)
  check_file_content(file_name, content, true)
end
