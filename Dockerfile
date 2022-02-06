FROM golang:1.17.6-alpine as build-env
RUN go install -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest

FROM alpine:3.15.0
RUN apk add --no-cache bind-tools ca-certificates chromium
COPY --from=build-env /go/bin/nuclei /usr/local/bin/nuclei
RUN nuclei -update-templates
COPY nuclei-templates/cves/2021/CVE-2021-44228.yaml /root/nuclei-templates/cves/2021/
ENTRYPOINT ["nuclei"]
