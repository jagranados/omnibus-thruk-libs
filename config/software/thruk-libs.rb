name "thruk-libs"
default_version "1.0"
dependency "zlib"
dependency "openssl"
dependency "cpanminus"
dependency "perl-extutils-makemaker-local"
dependency "gd"
dependency "expat"
dependency "mysql-client"

build do
env = with_standard_compiler_flags(with_embedded_path)
  env.merge!(
    "PERL_MM_USE_DEFAULT" => "1",
  )

  xml_env = with_standard_compiler_flags(with_embedded_path).merge!(
     "PERL_MM_USE_DEFAULT" => "1",
     "PERL_MM_OPT" => "EXPATLIBPATH=#{install_dir}/embedded/lib EXPATINCPATH=#{install_dir}/embedded/include"
   )
   command "EXPATLIBPATH=#{install_dir}/embedded/lib EXPATINCPATH=#{install_dir}/embedded/include #{install_dir}/embedded/bin/cpan  XML::Parser", env: xml_env
   #command "#{install_dir}/embedded/bin/cpanm -vn XML::Parser", env: env

   net_ssleay_env = with_standard_compiler_flags(with_embedded_path).merge!(
     "PERL_MM_USE_DEFAULT" => "1",
     "PERL_MM_OPT" => "OPENSSL_PREFIX=#{install_dir}/embedded"
   )
   command "#{install_dir}/embedded/bin/cpan  Net::SSLeay", env: net_ssleay_env

command "
     #{install_dir}/embedded/bin/cpanm -vn Plack
     #{install_dir}/embedded/bin/cpanm -vn FCGI
     #{install_dir}/embedded/bin/cpanm -vn JSON::XS
     #{install_dir}/embedded/bin/cpanm -vn HTTP::Response
     #{install_dir}/embedded/bin/cpanm -vn HTTP::Request
     #{install_dir}/embedded/bin/cpanm -vn LWP::UserAgent
     #{install_dir}/embedded/bin/cpanm -vn Net::HTTP
     #{install_dir}/embedded/bin/cpanm -vn URI::Escape
     #{install_dir}/embedded/bin/cpanm -vn HTML::Entities
     #{install_dir}/embedded/bin/cpanm -vn Socket
     #{install_dir}/embedded/bin/cpanm -vn GD
     #{install_dir}/embedded/bin/cpanm -vn Template
     #{install_dir}/embedded/bin/cpanm -vn Date::Calc
     #{install_dir}/embedded/bin/cpanm -vn File::Slurp
     #{install_dir}/embedded/bin/cpanm -vn Date::Manip
     #{install_dir}/embedded/bin/cpanm -vn DateTime::TimeZone
     #{install_dir}/embedded/bin/cpanm -vn DateTime
     #{install_dir}/embedded/bin/cpanm -vn Excel::Template
     #{install_dir}/embedded/bin/cpanm -vn IO::String
     #{install_dir}/embedded/bin/cpanm -vn Log::Log4perl
     #{install_dir}/embedded/bin/cpanm -vn Log::Dispatch::File
     #{install_dir}/embedded/bin/cpanm -vn Storable
     #{install_dir}/embedded/bin/cpanm -vn threads
     #{install_dir}/embedded/bin/cpanm -vn Thread::Queue
     #{install_dir}/embedded/bin/cpanm -vn Time::HiRes
     #{install_dir}/embedded/bin/cpanm -vn MIME::Lite
     #{install_dir}/embedded/bin/cpanm -vn Class::Inspector
     #{install_dir}/embedded/bin/cpanm -vn LWP::Protocol::https
     #{install_dir}/embedded/bin/cpanm -vn LWP::Protocol::connect
     #{install_dir}/embedded/bin/cpanm -vn DBI
     #{install_dir}/embedded/bin/cpanm -vn DBD::mysql
     #{install_dir}/embedded/bin/cpanm -vn HTML::Escape
   ", env: env




end


