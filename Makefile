.PHONY: build fmt test vet clean

SRC = $(shell find . -type f -name '*.go' -not -path "./vendor/*")
CLEAN := *~

default: build

install.tools: .install.protoc-go-go

CLEAN += .install.protoc-go-go
.install.protoc-go-go:
	go get -u -v github.com/gogo/protobuf/protoc-gen-gogo && touch $@

build:  vet fmt grafeas_go
	go build -v ./...

# http://golang.org/cmd/go/#hdr-Run_gofmt_on_package_sources
fmt:
	@gofmt -l -w $(SRC)

test:
	@go test -v ./... 

vet:
	@go tool vet ${SRC}

v1alpha1/proto/grafeas.pb.go: .install.protoc-go-go v1alpha1/proto/grafeas.proto
	protoc \
		-I. \
		-I ./vendor/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis \
		-I ./vendor/github.com/googleapis/googleapis \
		--gogo_out=plugins=grpc=:. \
		./v1alpha1/proto/grafeas.proto

.PHONY: grafeas_go
grafeas_go: v1alpha1/proto/grafeas.pb.go fmt

clean:
	go clean ./...
	rm -f $(CLEAN)

