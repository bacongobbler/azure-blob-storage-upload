FROM mcr.microsoft.com/azure-cli:2.33.1

LABEL "com.github.actions.name"="azure-blob-storage-upload"
LABEL "com.github.actions.description"="Uploads assets to Azure Blob Storage"
LABEL "com.github.actions.icon"="box"
LABEL "com.github.actions.color"="green"
LABEL "repository"="https://github.com/bacongobbler/azure-blob-storage-upload"
LABEL "homepage"="https://github.com/bacongobbler/azure-blob-storage-upload"
LABEL "maintainer"="Matthew Fisher <matt.fisher@microsoft.com>"

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
