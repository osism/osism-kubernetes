# SPDX-License-Identifier: Apache-2.0

import jinja2
import yaml

# load versions files from release repository

with open("/release/latest/base.yml", "rb") as fp:
    versions = yaml.load(fp, Loader=yaml.FullLoader)

# prepare jinja2 environment

loader = jinja2.FileSystemLoader(searchpath="/src/templates/")
environment = jinja2.Environment(loader=loader)

# render versions.yml

template = environment.get_template("versions.yml.j2")
result = template.render({"osism_kubernetes_version": versions["manager_version"]})

with open("/ansible/group_vars/all/versions.yml", "w+") as fp:
    fp.write(result)

# render motd

template = environment.get_template("motd.j2")
result = template.render({"manager_version": versions["manager_version"]})
with open("/etc/motd", "w+") as fp:
    fp.write(result)
