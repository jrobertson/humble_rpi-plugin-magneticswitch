Gem::Specification.new do |s|
  s.name = 'humble_rpi-plugin-magneticswitch'
  s.version = '0.3.1'
  s.summary = 'A Humble RPi plugin which detects the opening or closing of a door using a magnetic switch sensor.'
  s.authors = ['James Robertson']
  s.files = Dir['lib/humble_rpi-plugin-magneticswitch.rb']
  s.add_runtime_dependency('rpi_pinin', '~> 0.1', '>=0.1.2')
  s.add_runtime_dependency('self-defense', '~> 0.1', '>=0.1.5')
  s.signing_key = '../privatekeys/humble_rpi-plugin-magneticswitch.pem'
  s.cert_chain  = ['gem-public_cert.pem']
  s.license = 'MIT'
  s.email = 'james@r0bertson.co.uk'
  s.homepage = 'https://github.com/jrobertson/humble_rpi-plugin-magneticswitch'
end
