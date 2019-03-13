# Copyright 2018 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

project_id   = attribute('project_id')
network_name = attribute('network_name')

control "gcp" do
  title "Google Cloud configuration"

  describe google_compute_network(
    project: project_id,
    name: network_name
  ) do
    it { should exist }
  end

  describe google_compute_subnetwork(
    project: project_id,
    name: "#{network_name}-subnet-01",
    region: "us-west1"
  ) do
    it { should exist }
    its('ip_cidr_range') { should eq "10.10.10.0/24" }
    its('private_ip_google_access') { should be false }
  end

  describe google_compute_subnetwork(
    project: project_id,
    name: "#{network_name}-subnet-02",
    region: "us-west1"
  ) do
    it { should exist }
    its('ip_cidr_range') { should eq "10.10.20.0/24" }
    its('private_ip_google_access') { should be true }
  end
end
