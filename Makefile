deps: tidy
	go install gotest.tools/gotestsum@latest
	go install github.com/securego/gosec/v2/cmd/gosec@latest
	go install github.com/golang/mock/mockgen@latest
	go mod verify
	chmod 700 ./scripts/*.sh

tidy:
	@go mod tidy
	@go mod verify

fmt:
	go fmt ./...

sec: tidy
	gosec -tests ./...

coverage.txt: tidy
	@go test -coverprofile coverage.txt.tmp ./...
	@cat coverage.txt.tmp | grep -v "_mocks.go" > coverage.txt
	@rm -fr coverage.txt.tmp*

tests-html: coverage.txt
	@go tool cover -html=coverage.txt -o ./reports/coverage.html
	@rm -rf coverage.txt

tests: coverage.txt
	@go tool cover -func coverage.txt
	@rm -rf coverage.txt

tests-xml: tidy
	gotestsum --junitfile rspec.xml

mocks:
	chmod 700 ./scripts/mock.sh
	./scripts/mock.sh

clear:
	go clean -cache -modcache -i -r

debug: tidy
	@go run ./cmd/demo.go
