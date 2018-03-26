#
# Copyright:: Copyright (c) 2013 Robby Dyer
# Copyright:: Copyright (c) 2014 GitLab.com
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
name "mysql-client"
default_version "5.6.20"

dependency "openssl"
dependency "zlib"
dependency "ncurses"

# This dependecy is only necessary for ubuntu because
# debian has it installed by default on the base system
if ohai['platform'].eql? ("ubuntu")
  dependency "curl"
end

source  :url => "http://downloads.mysql.com/archives/get/file/mysql-#{version}.tar.gz",
        :md5 => "71ed71ecc53222a2f03523cd13cf2141"

relative_path "mysql-#{version}"

env = {
  "CMAKE_PREFIX_PATH" => "#{install_dir}/embedded",
  "LDFLAGS" => "-L#{install_dir}/embedded/lib -L#{install_dir}/embedded/lib64 -I#{install_dir}/embedded/include",
  "CFLAGS" => "-L#{install_dir}/embedded/lib -L#{install_dir}/embedded/lib64",
  "CXXFLAGS" => "-L#{install_dir}/embedded/lib -L#{install_dir}/embedded/lib64",
  "CPPFLAGS" => "-L#{install_dir}/embedded/lib -L#{install_dir}/embedded/lib64",
  "LD_RUN_PATH" => "#{install_dir}/embedded/lib",
  "LD_LIBRARY_PATH" => "#{install_dir}/embedded/lib",
}

build do

  command [
            "cmake",
            "-DWITHOUT_SERVER=ON",
            "-DCMAKE_SKIP_RPATH=YES",
            "-DCMAKE_INSTALL_PREFIX=#{install_dir}/embedded",
            "-DWITH_SSL=bundled",
            "-DWITH_ZLIB=system",
            "-DCRYPTO_LIBRARY:FILEPATH=#{install_dir}/embedded/lib/libcrypto.so",
            ".",
           ].join(" "), :env => env

  make "-j #{workers}", env: env
  make "install", env: env
  command "cp scripts/mysql_config #{install_dir}/embedded/bin/"
end
