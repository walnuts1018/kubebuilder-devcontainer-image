FROM golang:1.23.4-bookworm

RUN curl -Lo /usr/local/bin/kind https://kind.sigs.k8s.io/dl/latest/kind-linux-amd64 && chmod +x /usr/local/bin/kind

RUN curl -L -o /usr/local/bin/kubebuilder https://go.kubebuilder.io/dl/latest/linux/amd64 && chmod +x /usr/local/bin/kubebuilder

RUN KUBECTL_VERSION=$(curl -L -s https://dl.k8s.io/release/stable.txt) && curl -L -o /usr/local/bin/kubectl "https://dl.k8s.io/release/$KUBECTL_VERSION/bin/linux/amd64/kubectl" && chmod +x /usr/local/bin/kubectl
