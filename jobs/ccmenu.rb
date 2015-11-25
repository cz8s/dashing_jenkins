require './lib/ccmenu'

SCHEDULER.every '20s', :first_in => 0 do |job|
    jenkins = CCMenu.new 'https://yourjenins/cc.xml'
    send_event('jenkins', {items:jenkins.failed, color: jenkins.color})
end


