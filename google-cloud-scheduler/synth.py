# Copyright 2018 Google LLC
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

"""This script is used to synthesize generated parts of this library."""

import synthtool as s
import synthtool.gcp as gcp
import synthtool.languages.ruby as ruby
import logging

logging.basicConfig(level=logging.DEBUG)

gapic = gcp.GAPICMicrogenerator()
library = gapic.ruby_library(
    "scheduler", "v1",
    generator_args={
        "ruby-cloud-gem-name": "google-cloud-scheduler",
        "ruby-cloud-title": "Cloud Scheduler",
        "ruby-cloud-description": "Cloud Scheduler is a fully managed enterprise-grade cron job scheduler. It allows you to schedule virtually any job, including batch, big data jobs, cloud infrastructure operations, and more. You can automate everything, including retries in case of failure to reduce manual toil and intervention. Cloud Scheduler even acts as a single pane of glass, allowing you to manage all your automation tasks from one place.",
        "ruby-cloud-env-prefix": "SCHEDULER",
        "ruby-cloud-wrapper-of": "v1:0.0;v1beta1:0.0",
        "ruby-cloud-product-url": "https://cloud.google.com/scheduler",
        "ruby-cloud-api-id": "cloudscheduler",
        "ruby-cloud-migration-version": "2.0",
    }
)

s.copy(library, merge=ruby.global_merge)
