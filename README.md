# go-core

go-toolkit

Setup connection to repo without ssh (Encourage)


Tells Golang command line tools to not use public internet resources

go env -w GO111MODULE="on"
go env -w GOPRIVATE="gitlab.com"




It might be necessary to also run the following:

go env -w GONOPROXY=gitlab.com
go env -w GONOSUMDB=gitlab.com




In order for the Golang command line tools to authenticate to GitLab, a ~/.netrc file is best to use.

touch ~/.netrc
chmod 600 ~/.netrc
echo -e "machine gitlab.com login <token-account> password <token>" > ~/.netrc




Good job !