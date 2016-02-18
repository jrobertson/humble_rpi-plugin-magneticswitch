#!/usr/bin/env ruby

# file: humble_rpi-plugin-magneticswitch.rb


require 'pi_piper'


class HumbleRPiPluginMagneticSwitch
  include PiPiper

  def initialize(settings: {}, variables: {})

    @nc = settings[:nc] || true
    @pins = settings[:pins]
    @notifier = variables[:notifier]
    @device_id = variables[:device_id] || 'pi'
      
    at_exit do
      
      @pins.each do |pin|

        uexp = open("/sys/class/gpio/unexport", "w")
        uexp.write(pin)
        uexp.close
      
      end
    end

    
  end

  def start()
    
    notifier = @notifier
    device_id = @device_id
    nc = @nc
        
    puts 'ready to detect magnetic switches'
    
    @pins.each.with_index do |button, i|
      
      puts 'magnetic switch sensor %s on GPIO %s enabled ' % [i+1, button]
      
      n = (i+1).to_s
      
      PiPiper.watch :pin => button.to_i, :invert => nc do |pin|
        
        state = case pin.value
        when 1
          :open
        when 0          
          :closed
        end
        
        notifier.notice "%s/magneticswitch/%s: door %s" % [device_id, i, state]

      end
      
    end
    
    PiPiper.wait    

    
  end
  
  alias on_start start
  
  
end
