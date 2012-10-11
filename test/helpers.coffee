# Copyright 2011-2012 Amazon.com, Inc. or its affiliates. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License"). You
# may not use this file except in compliance with the License. A copy of
# the License is located at
#
#     http://aws.amazon.com/apache2.0/
#
# or in the "license" file accompanying this file. This file is
# distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF
# ANY KIND, either express or implied. See the License for the specific
# language governing permissions and limitations under the License.

sync = (code, finished) ->
  resp = null
  runs ->
    code() ->
      resp = arguments
  waitsFor -> resp != null
  runs -> finished(resp)

integration = (reqBuilder, respCallback) ->
  req = reqBuilder()
  resp = null
  runs -> req.always (respObject) -> resp = respObject
  waitsFor -> resp != null
  runs -> respCallback(resp)

module.exports =
  AWS: require('../lib/aws')
  sync: sync
  integration: integration
