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
import re
from subprocess import call


logging.basicConfig(level=logging.DEBUG)

gapic = gcp.GAPICGenerator()

v2beta2_library = gapic.ruby_library(
    'tasks', 'v2beta2', artman_output_name='google-cloud-ruby/google-cloud-tasks',
    config_path='artman_cloudtasks_v2beta2.yaml'
)
s.copy(v2beta2_library / 'lib/google/cloud/tasks/v2beta2')
s.copy(v2beta2_library / 'lib/google/cloud/tasks/v2beta2.rb')
s.copy(v2beta2_library / 'test/google/cloud/tasks/v2beta2')

v2beta3_library = gapic.ruby_library(
    'tasks', 'v2beta3', artman_output_name='google-cloud-ruby/google-cloud-tasks',
    config_path='artman_cloudtasks_v2beta3.yaml'
)
s.copy(v2beta3_library / 'lib/google/cloud/tasks.rb')
s.copy(v2beta3_library / 'lib/google/cloud/tasks/v2beta3')
s.copy(v2beta3_library / 'lib/google/cloud/tasks/v2beta3.rb')
s.copy(v2beta3_library / 'test/google/cloud/tasks/v2beta3')
s.copy(v2beta3_library / 'README.md')
s.copy(v2beta3_library / 'LICENSE')
s.copy(v2beta3_library / '.gitignore')
s.copy(v2beta3_library / '.yardopts')
s.copy(v2beta3_library / 'google-cloud-tasks.gemspec', merge=ruby.merge_gemspec)

# https://github.com/googleapis/gapic-generator/issues/2180
s.replace(
    'google-cloud-tasks.gemspec',
    '\n  gem\\.add_dependency "google-gax", "~> ([\\d\\.]+)"\n\n',
    '\n  gem.add_dependency "google-gax", "~> \\1"\n  gem.add_dependency "grpc-google-iam-v1", "~> 0.6.9"\n\n')

# https://github.com/googleapis/gapic-generator/issues/2242
def escape_braces(match):
    expr = re.compile('^([^`]*(`[^`]*`[^`]*)*)([^`#\\$\\\\])\\{([\\w,]+)\\}')
    content = match.group(0)
    while True:
        content, count = expr.subn('\\1\\3\\\\\\\\{\\4}', content)
        if count == 0:
            return content
s.replace(
    'lib/google/cloud/**/*.rb',
    '\n(\\s+)#[^\n]*[^\n#\\$\\\\]\\{[\\w,]+\\}',
    escape_braces)

# https://github.com/googleapis/gapic-generator/issues/2243
s.replace(
    'lib/google/cloud/tasks/*/*_client.rb',
    '(\n\\s+class \\w+Client\n)(\\s+)(attr_reader :\\w+_stub)',
    '\\1\\2# @private\n\\2\\3')

# https://github.com/googleapis/gapic-generator/issues/2279
s.replace(
    'lib/**/*.rb',
    '\\A(((#[^\n]*)?\n)*# (Copyright \\d+|Generated by the protocol buffer compiler)[^\n]+\n(#[^\n]*\n)*\n)([^\n])',
    '\\1\n\\6')

# https://github.com/googleapis/gapic-generator/issues/2323
s.replace(
    [
        'lib/**/*.rb',
        'README.md'
    ],
    'https://github\\.com/GoogleCloudPlatform/google-cloud-ruby',
    'https://github.com/googleapis/google-cloud-ruby'
)
s.replace(
    [
        'lib/**/*.rb',
        'README.md'
    ],
    'https://googlecloudplatform\\.github\\.io/google-cloud-ruby',
    'https://googleapis.github.io/google-cloud-ruby'
)

# https://github.com/googleapis/gapic-generator/issues/2393
s.replace(
    'google-cloud-tasks.gemspec',
    'gem.add_development_dependency "rubocop".*$',
    'gem.add_development_dependency "rubocop", "~> 0.64.0"'
)

for version in ['v2beta2', 'v2beta3']:
    # Require the helpers file
    s.replace(
        f'lib/google/cloud/tasks/{version}.rb',
        f'require "google/cloud/tasks/{version}/cloud_tasks_client"',
        '\n'.join([
            f'require "google/cloud/tasks/{version}/cloud_tasks_client"',
            f'require "google/cloud/tasks/{version}/helpers"',
        ])
    )

# Generate the helper methods
call('bundle update && bundle exec rake generate_partials', shell=True)
