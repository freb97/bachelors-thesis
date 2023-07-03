FROM alpine:latest AS latex-setup

# Install texlive and biber
RUN apk add --no-cache biber texlive-full

# TexLive multithreading settings
RUN sed -i 's/extra_mem_bot = .*/extra_mem_bot = 2000000/' /usr/share/texmf-dist/web2c/texmf.cnf
RUN sed -i 's/pool_size = .*/pool_size = 12500000/' /usr/share/texmf-dist/web2c/texmf.cnf
RUN fmtutil-sys --byfmt=pdflatex

# Install python3 and pip and inkscape
RUN apk add python3 py3-pip

# Install Pygments via pip for using the 'minted' latex package
RUN pip install Pygments
