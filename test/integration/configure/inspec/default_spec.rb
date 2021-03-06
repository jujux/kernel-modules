# Cookbook Name:: kernel-modules
# Author:: Jeremy MAURO <j.mauro@criteo.com>
#
# Copyright 2016, Criteo.
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

require(File.expand_path('../../helpers/inspec/spec_helper', File.dirname(__FILE__)))

describe file(module_path(:init, os['release'].to_i, 'firewire-core')) do
  it { should_not exist }
end

describe kernel_module('firewire-core') do
  it { should_not be_loaded }
end

if os[:release].to_i == 6
  describe file(module_path(:init, os[:release].to_i, 'nfs')) do
    it { should exist }
  end

  describe kernel_module('nfs') do
    it { should_not be_loaded }
  end

  describe file(module_path(:load, os[:release].to_i, 'nfs')) do
    it { should exist }
  end
end

if os[:release].to_i == 7
  describe file(module_path(:init, os[:release].to_i, 'btusb')) do
    it { should exist }
  end

  describe file(module_path(:load, os[:release].to_i, 'btusb')) do
    it { should exist }
  end

  describe kernel_module('btusb') do
    it { should_not be_loaded }
  end
end
