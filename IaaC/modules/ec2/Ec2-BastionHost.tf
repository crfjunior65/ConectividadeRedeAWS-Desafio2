resource "aws_instance" "ec2_bia_dev" {

  depends_on = [aws_key_pair.deployer]

  #count = 1
  #ami   = var.amis["Ubnt-us-east-1"]
  #ami           = data.aws_ami.ubuntu_linux.id
  #data.terraform_remote_state.remote-state-information.outputs.autor
  #ami = data.aws_ami.amazon_linux.id
  ami = data.aws_ami.amazon_linux_2023.id
  #data.terraform_remote_state.vpc.outputs.ami_amazon_linux.id
  instance_type = "t3.micro"

  # Configuração do volume raiz (EBS)
  root_block_device {
    volume_size = 15    # Tamanho em GiB (padrão: 8GB para muitas AMIs)
    volume_type = "gp3" # Tipo de volume (gp2, gp3, io1, etc.)
    #delete_on_termination = true
  }

  # Configuração do volume EF

  key_name = var.key_name

  #Selecionar SubRede
  #subnet_id = module.vpc.vpc_id.public_subnets[0]
  subnet_id = data.terraform_remote_state.vpc.outputs.vpc_public_subnets_id[0]
  # module.vpc.public_subnets[0]

  #Atribuir IP Publico
  associate_public_ip_address = true

  user_data = file("InstallBia.sh")

  # Associar o Role SSM à instância EC2
  iam_instance_profile = data.terraform_remote_state.iam.outputs.iam_ssm_profile.id

  tags = {
    Name        = "Bia-Dev"
    Ambiente    = "Dev"
    Funcao      = "BastionHost"
    Terraform   = "true"
    Environment = "Projeto"
    Management  = "Terraform"
    #Id_EFS      = data.terraform_remote_state.efs.outputs.efs_fs_id
  }

  vpc_security_group_ids = ["${data.terraform_remote_state.sg.outputs.sg_bia_dev}"]



  provisioner "file" {
    source      = "Substituir_DB_HOST.sh"
    destination = "/home/ec2-user/Substituir_DB_HOST.sh"
  }

  provisioner "file" {
    source      = "backup_restore_bia.sh"
    destination = "/home/ec2-user/backup_restore_bia.sh"
  }


  provisioner "remote-exec" {
    inline = [
      "mkdir -p /home/ec2-user/Bia",
      "cd /home/ec2-user/Bia",
      "echo '${data.terraform_remote_state.rds.outputs.db_db_address}' >> .env",
      "echo '${aws_instance.ec2_bia_dev.public_ip}' > .PublicIP",
      "cd ..",
      "sleep 185",
      "sudo chown -R ec2-user:ec2-user *",
      "chmod +x /home/ec2-user/Substituir_DB_HOST.sh",
      "chmod +x /home/ec2-user/backup_restore_bia.sh",
      "/home/ec2-user/Substituir_DB_HOST.sh",
      "cd /home/ec2-user/bia",
      "sudo docker compose up -d",
      "sleep 15",
      "sudo docker compose exec server bash -c 'npx sequelize db:migrate'"

      #"docker compose exec server bash -c 'npx sequelize db:seed:all'"
      #"docker compose -d up",
      #"docker compose exec server bash -c 'npx sequelize db:migrate'"
    ]

  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("aws-key-terraform")
    host        = self.public_ip
    timeout     = "55s"
  }
}