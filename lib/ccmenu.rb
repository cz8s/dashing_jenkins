require 'crack'
require 'open-uri'
require 'json'

class CCMenu

  def initialize(url)
    @data = Crack::XML.parse(open(url,http_basic_authentication: [ENV['JENKINS_USER'],ENV['JENKINS_PASS']],ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE))['Projects']['Project']
    @data=@data.select{ |i| i['name'][/^[^\:\:]*\:\:[^\:\:]*$/]}
  end

  def json
    @data.to_json
  end

  def status
    overall = 'Success'
    @data.each do |step|
      if step['lastBuildStatus'] != 'Success'
        overall = step['lastBuildStatus']
      end
    end
    return overall
  end
  def failed
    list = Array.new
    @data.each do |step|
      list << step['name'] if step['lastBuildStatus'] == 'Failure'
    end
    return list
  end

  def num_total
    @data.length
  end

  def num_failed
    self.failed.length
  end

  def color
    case status
      when 'Failure'   then 'red'
      when 'Exception' then 'orange'
      when 'Unknown'   then 'orange'
      else 'green'
    end
  end


  def data
    @data
  end
end
