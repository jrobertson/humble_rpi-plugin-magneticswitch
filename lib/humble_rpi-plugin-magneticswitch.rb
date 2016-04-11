#!/usr/bin/env ruby

# file: humble_rpi-plugin-magneticswitch.rb


require 'rpi_pinin'


class HumbleRPiPluginMagneticSwitch


  def initialize(settings: {}, variables: {})

    @nc = settings[:nc] || true
    @pins = settings[:pins].map {|x| RPiPinIn.new x, pull: :up}
    @notifier = variables[:notifier]
    @device_id = variables[:device_id] || 'pi'      
    
  end

  def start()
    
    notifier = @notifier
    device_id = @device_id
    nc = @nc
        
    puts 'ready to detect magnetic switches'
    
    @pins.each.with_index do |pin, i|
      
      puts 'magnetic switch sensor %s on GPIO %s enabled ' % [i+1, pin.to_s]
      
      n = (i+1).to_s
      
      Thread.new do      
        
        pin.watch do |value|
          
          state = value == 0 ? :open : :closed
          
          notifier.notice "%s/magneticswitch/%s: door %s" % \
                                                      [device_id, i, state]
          
        end
        
      end
      
    end
    
  end
  
  alias on_start start
  
  
end