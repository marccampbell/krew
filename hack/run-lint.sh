#!/usr/bin/env bash

# Copyright 2019 The Kubernetes Authors.
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

set -euo pipefail

[[ -n "${DEBUG:-}" ]] && set -x

gopath="$(go env GOPATH)"

if ! [[ -x "$gopath/bin/golangci-lint" ]]
then
   echo >&2 'Installing golangci-lint'
   curl --silent --fail --location \
       https://install.goreleaser.com/github.com/golangci/golangci-lint.sh | sh -s -- -b "$gopath/bin" v1.17.1
fi

# configured by .golangci.yml
exec env GO111MODULE=on "$gopath/bin/golangci-lint" run
