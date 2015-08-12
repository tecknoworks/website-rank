require 'json'
require 'resolv-replace.rb'

class Ranker
  def initialize url
    result = initiate_job url
    @sid = result["sid"]
    json = {}
    circuit_break do
      json = get_result(job_id)
    end

    @json = json
  end

  def mk_req(cmd)
    resp = `#{cmd}`
    JSON.parse(resp.strip)
  end

  def initiate_job(website)
    cmd = "curl 'http://api.ready.mobi/api/v1/page/add/' -H 'Origin: http://api.ready.mobi' -H 'Accept-Encoding: gzip, deflate' -H 'Content-Type: application/x-www-form-urlencoded; charset=UTF-8' -H 'X-Requested-With: XMLHttpRequest' -H 'Connection: keep-alive' --data 'key=00000000-0000-0000-0000-000000000000&url=#{website}' --compressed"
    mk_req cmd
  end

  def get_result(job_id)
    cmd = "curl 'http://api.ready.mobi/api/v1/page/#{job_id}?key=00000000-0000-0000-0000-000000000000'"
    mk_req cmd
  end


  def get_results(job_id, try_count = 0)
    if try_count > 5
      puts 'breaking circuit'
      return
    end
    try_count += 1
    cmd = "curl 'http://api.ready.mobi/api/v1/page/#{job_id}?key=00000000-0000-0000-0000-000000000000'"
    json = mk_req cmd
    if json['responseCode'] == 2
      json
    else
      puts 'waiting for results..'
      sleep 1
      get_results(job_id, try_count)
    end
  end

  def circuit_break(try_count = 0)
    json = yield
    try_count += 1
    if try_count > 2
      # here we would normally throw an error but we just want the last result
      return json
    end
    if json['responseCode'] == 2
      json
    else
      circuit_break(try_count) do
        yield
      end
    end
  end
end
