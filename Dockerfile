FROM alpine:latest AS latex-setup

# Install texlive and biber
RUN apk add --no-cache biber texlive-full


FROM latex-setup AS pygments-setup

# Install python3 and pip
RUN apk add --no-cache python3 py3-pip

# Install Pygments via pip for using the 'minted' latex package
RUN pip install Pygments
