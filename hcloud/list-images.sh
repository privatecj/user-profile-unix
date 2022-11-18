#!/bin/bash


hcloud image list -o columns=id,description | grep "snapshot" | tail -1