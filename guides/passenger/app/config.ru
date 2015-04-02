app = proc do |env|
    [200, { "Content-Type" => "text/html" }, ["Congratulations you successfully followed the guide from <b>community.ulyaoth.net</b> and your Passenger installation is working!"]]
end
run app