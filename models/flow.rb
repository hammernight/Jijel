class Flow

  attr_accessor :path, :name, :site, :content, :filename

  def self.load_flows(site)
    flows = Array.new
    Dir["#{File.dirname(site.path)}/../../lib/sites/#{site.name.split(' ').map {|w| w.downcase}.join('_')}/flows/**/*.rb"].each do |flow_path|
      flow = Flow.new
      flow.path = flow_path
      flow.filename = File.basename flow_path, '.rb'
      flow.name = FileHelper.pretty flow.filename
      flow.site = site
      flow.content = File.open(flow_path, 'rb').read
      flows << flow
    end
    flows.sort {|a,b| a.name <=> b.name}
  end

end