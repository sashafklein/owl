if File.exists?("congfig/env.yml")
  hash = YAML.load_file(File.join(Rails.root, 'config', 'env.yml'))
  hash.each do |key, value|
    ENV[key] = value
  end
end
