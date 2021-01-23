require 'uri'

Puppet::Functions.create_function(:url_parse) do
  dispatch :url_parse do
    param 'String', :url
    param 'String', :property
  end

  def url_parse(url, property)
    url = URI.parse url
    case property
    when 'scheme' then url.scheme
    when 'userinfo' then url.userinfo
    when 'user' then url.user
    when 'password' then url.password
    when 'host' then url.host
    when 'port' then url.port
    when 'path' then url.path
    when 'query' then url.query
    when 'filename' then File.basename url.path
    when 'filetype' then File.extname url.path
    when 'filedir' then (File.basename url.path).chomp(File.extname(url.path))
    else url
    end
  end
end
