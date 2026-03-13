FROM alpine:3.23

RUN apk add --no-cache \
        bash \
        biber \
        ca-certificates \
        fontconfig \
        make \
        perl \
        texlive \
        texlive-binextra \
	texlive-latexextra \
	texlive-latexrecommended \
	texlive-luatex \
	texlive-mathscience \
	texlive-pictures \
	texlive-plaingeneric

WORKDIR /work
