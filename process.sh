#!/bin/bash
#  Copyright 2016 ARC Centre of Excellence for Climate Systems Science
#
#  \author  Scott Wales <scott.wales@unimelb.edu.au>
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.

sed -e 's/#.*//' -e '/a2i.nc/!d' -e 's/\(\S\+\)\s\(\S\+\)\s.*/FIELD(\1, \2, OUT)/' namcouple > atmos.x
sed -e 's/#.*//' -e '/i2a.nc/!d' -e 's/\(\S\+\)\s\(\S\+\)\s.*/FIELD(\2, \1, IN)/' namcouple >> atmos.x

sed -e 's/#.*//' -e '/i2a.nc/!d' -e 's/\(\S\+\)\s\(\S\+\)\s.*/FIELD(\1, \2, OUT)/' namcouple > ice.x
sed -e 's/#.*//' -e '/i2o.nc/!d' -e 's/\(\S\+\)\s\(\S\+\)\s.*/FIELD(\1, \2, OUT)/' namcouple >> ice.x
sed -e 's/#.*//' -e '/a2i.nc/!d' -e 's/\(\S\+\)\s\(\S\+\)\s.*/FIELD(\2, \1, IN)/' namcouple >> ice.x
sed -e 's/#.*//' -e '/o2i.nc/!d' -e 's/\(\S\+\)\s\(\S\+\)\s.*/FIELD(\2, \1, IN)/' namcouple >> ice.x

sed -e 's/#.*//' -e '/o2i.nc/!d' -e 's/\(\S\+\)\s\(\S\+\)\s.*/FIELD(\1, \2, OUT)/' namcouple > ocean.x
sed -e 's/#.*//' -e '/i2o.nc/!d' -e 's/\(\S\+\)\s\(\S\+\)\s.*/FIELD(\2, \1, IN)/' namcouple >> ocean.x
