# 5. Helm Installation: NGINX Ingress Controller
#
# This installs the NGINX Ingress Controller, which creates a 
# DigitalOcean LoadBalancer to accept external traffic and route it
# to our application services based on the Ingress rules.
resource "helm_release" "nginx-ingress" {
  name             = "nginx-ingress"
  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"
  namespace        = "ingress-nginx"
  create_namespace = true
  version          = "4.8.3"

  # Using values array to avoid the 'set' block issue in some IDEs
  values = [
    yamlencode({
      controller = {
        publishService = {
          enabled = true
        }
      }
    })
  ]
}
