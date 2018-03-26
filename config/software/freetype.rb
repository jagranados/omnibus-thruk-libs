name "freetype"
default_version "2.4.12"

source :url => "http://downloads.sourceforge.net/project/freetype/freetype2/#{version}/freetype-#{version}.tar.bz2",
       :md5 => "3463102764315eb86c0d3c2e1f3ffb7d"

relative_path "freetype-#{version}"

build do
  env = with_standard_compiler_flags(with_embedded_path)

  command "./configure --prefix=#{install_dir}/embedded", :env => env
  make "-j #{workers}", env: env
  make "install", env: env
end