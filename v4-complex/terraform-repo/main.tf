
resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false
}

#resource "docker_container" "nginx" {
#  image = docker_image.nginx.latest
#  name  = "v4"
#  ports {
#    internal = 80
#    external = 8000
#  }
#}


resource "docker_container" "hello_world_app" {
  image = "hello_world_app:latest"
  name  = "hello_world_app"
  restart = "always"
  volumes {
    container_path  = "/myapp"
    host_path = "/Users/hans/Dropbox/hans/uc/terraform/v4-complex/node-app" 
    read_only = false
  }
  ports {
    internal = 8080
    external = 8080
  }
}