Pod::Spec.new do |s|
  s.name = "PointFree-Validated"
  s.module_name "Validated"
  s.version = "0.1.1"
  s.summary = "A result type that accumulates multiple errors."

  s.description = <<-DESC
  Swift error handling short-circuits on the first failure. Because of this, it's not the greatest option for handling things like form data, where multiple inputs may result in multiple errors.

  Validated is a Result-like type that can accumulate multiple errors.
  DESC

  s.homepage = "https://github.com/pointfreeco/swift-validated"

  s.license = "MIT"

  s.authors = {
    "Stephen Celis" => "stephen@stephencelis.com",
    "Brandon Williams" => "mbw234@gmail.com"
  }
  s.social_media_url = "https://twitter.com/pointfreeco"

  s.source = {
    :git => "https://github.com/pointfreeco/swift-validated.git",
    :tag => s.version
  }

  s.ios.deployment_target = "8.0"
  s.osx.deployment_target = "10.9"
  s.tvos.deployment_target = "9.0"
  s.watchos.deployment_target = "2.0"

  s.source_files  = "Sources", "Sources/**/*.swift"

  s.dependency "NonEmpty"
end
