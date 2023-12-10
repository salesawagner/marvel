Pod::Spec.new do |spec|

  spec.name = 'API'
  spec.version = '1.0.0'
  spec.summary = 'API client SDK'
  spec.homepage = 'http://www.wagnersales.com.br'

  spec.ios.deployment_target = '17.0'
  spec.swift_version = '5.0'

  spec.license = {
    :type => 'Private'
  }

  spec.author = {
    'Wagner Sales' => 'salesawagner@gmail.com'
  }

  spec.source = {
    :git => 'https://github.com/salesawagner/wasapi',
    :tag => 'API-' + spec.version.to_s
  }

  base_dir = 'API/'
  spec.source_files = base_dir + '**/*.{h,m,swift}'
  spec.resource_bundles = {
    'API' => base_dir + '**/*.json'
  }
end
