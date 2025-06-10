resource "local_file" "inventory" {
  filename = "../ansible/inventory.ini"

  content = join("\n", concat(
    ["[db]"],
    [for i in range(length(module.db.ec2_private_ips)) :
      "${module.db.ec2_names[i]} ansible_host=${module.db.ec2_private_ips[i]} ansible_user=ubuntu"
    ],
    ["[app]"],
    [for i in range(length(module.app.ec2_private_ips)) :
      "${module.app.ec2_names[i]} ansible_host=${module.app.ec2_private_ips[i]} ansible_user=ubuntu"
    ],
    ["[stage]"],
    [for i in range(length(module.stage.ec2_private_ips)) :
      "${module.stage.ec2_names[i]} ansible_host=${module.stage.ec2_private_ips[i]} ansible_user=ubuntu"
    ]
  ))
}