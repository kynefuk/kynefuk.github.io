FROM ghcr.io/afritzler/mkdocs-material
WORKDIR /opt
RUN apk add bash git
RUN pip install --upgrade pip && pip install  mkdocs-git-revision-date-localized-plugin