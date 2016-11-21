#!/usr/bin/env ruby

# file: humble_rpi-plugin-magneticswitch.rb


require 'rpi_pinin'
require 'self-defense'


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
          
          state = value == 0 ? :opened : :closed
          
          input_operation = :unknown
          
          strategy = lambda do |defense|

            coping_with_it = []
            coping_with_it << defense.rapid?(0.5)

            input_operation = coping_with_it.all? ? :normal : :erratic
          end

          # detect erratic input behaviour by checking if the door is 
          # opened within 0.5 of a second after it was last opened
          
          SelfDefense.new(&strategy) if state == :opened
          
          if input_operation == :erratic then
            
            notifier.notice "%s/magneticswitch/%s: " + \
                " door error: Erratic input operation" % [device_id, i]
            raise 'humble_rpi-plugin-magneticwitch: Erratic input operation'
          end
              
          notifier.notice "%s/magneticswitch/%s: door %s" % \
                                                  [device_id, i, state]
          
        end
        
      end
      
    end
    
  end
  
  alias on_start start
  
  
end