# Introducing the Humble_rpi-plugin-magneticswitch gem

## Testing the plugin

    require 'humble_rpi-plugin-magneticswitch'


    class Echo

      def notice(s)
        puts "%s: %s" % [Time.now, s]
      end
    end


    switch = HumbleRPiPluginMagneticSwitch.new(settings: {pins: [21]}, variables: {notifier: Echo.new})
    switch.start

Output:

<pre>
ready to detect magnetic switches
magnetic switch sensor 1 on GPIO 21 enabled
2016-02-18 21:21:47 +0000: pi/magneticswitch/0: door closed
2016-02-18 21:22:28 +0000: pi/magneticswitch/0: door open
2016-02-18 21:22:41 +0000: pi/magneticswitch/0: door closed
</pre>

## Running the plugin from the HumbleRPi gem

    require 'humble_rpi'
    require 'humble_rpi-plugin-magneticswitch'

    r = HumbleRPi.new device_name: 'ottavia', sps_address: '192.168.4.140',\
      plugins: {MagneticSensor: {pins: [21]} }
    r.start

## Resources

* humble_rpi-plugin-magneticswitch https://rubygems.org/gems/humble_rpi-plugin-magneticswitch

humblerpipluginmagneticswitch plugin humblerpi gem sensor
