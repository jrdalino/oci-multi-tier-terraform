resource "null_resource" "compute-script1" {
  depends_on = [
      oci_core_instance.webinstance1,
      oci_core_instance.webinstance2,
      oci_core_instance.dbinstance,
      oci_core_network_security_group_security_rule.dbnsgegress,
      oci_core_network_security_group_security_rule.dbnsgingress
      ]

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "opc"
      host        = oci_core_instance.webinstance1.public_ip
      private_key = tls_private_key.public_private_key_pair.private_key_pem
      script_path = "/home/opc/myssh.sh"
      agent       = false
      timeout     = "10m"
    }
    inline = [
      "echo '== [webinstance1] Step 1. Install Apache HTTP Server and php. Dependencies will be resolved automatically and installed.'",
      "sudo -u root yum -y update all",
      "sudo -u root yum -y install httpd",

      "echo '== [webinstance1] Step 2. Enable and start Apache HTTP Server.'",
      "sudo -u root service httpd start",

      "echo '== [webinstance1] Step 3. Allow HTTP in the local iptables firewall.'",
      "sudo -u root /sbin/iptables -I INPUT -p tcp -m tcp --dport 80 -j ACCEPT",
      "sudo -u root /sbin/service iptables save",

      "echo '== [webinstance1] Step 4. Install MySQL Shell.'",
      "sudo -u root yum -y install mysql",
      "echo '== Example: mysql -u USER-NAME-HERE -h MYSQL-DB-SERVER-IP-ADDRESS-HERE -p DB-NAME'"
      ]
  } 

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "opc"
      host        = oci_core_instance.webinstance2.public_ip
      private_key = tls_private_key.public_private_key_pair.private_key_pem
      script_path = "/home/opc/myssh.sh"
      agent       = false
      timeout     = "10m"
    }
    inline = [
      "echo '== [webinstance2] Step 1. Install Apache HTTP Server and php. Dependencies will be resolved automatically and installed.'",
      "sudo -u root yum -y update all",
      "sudo -u root yum -y install httpd",

      "echo '== [webinstance2] Step 2. Enable and start Apache HTTP Server.'",
      "sudo -u root service httpd start",

      "echo '== [webinstance2] Step 3. Allow HTTP in the local iptables firewall.'",
      "sudo -u root /sbin/iptables -I INPUT -p tcp -m tcp --dport 80 -j ACCEPT",
      "sudo -u root /sbin/service iptables save",

      "echo '== [webinstance2] Step 4. Install MySQL Shell.'",
      "sudo -u root yum -y install mysql",
      "echo '== Example: mysql -u USER-NAME-HERE -h MYSQL-DB-SERVER-IP-ADDRESS-HERE -p DB-NAME'"
      ]
  }  

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "opc"
      host        = oci_core_instance.dbinstance.public_ip
      private_key = tls_private_key.public_private_key_pair.private_key_pem
      script_path = "/home/opc/myssh.sh"
      agent       = false
      timeout     = "10m"
    }
    inline = [
      "echo '== [dbinstance] Step 1. Install and run MySQL'",
      "sudo -u root yum -y install mysql-server",
      "sudo -u root yum -y service mysqld start",
      "echo '== [dbinstance] Step 2: Set the root password for MySQL'",
      ]
  }  

}