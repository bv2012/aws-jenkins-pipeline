#!/bin/bash -e

sudo yum update -y
package-cleanup --oldkernels
