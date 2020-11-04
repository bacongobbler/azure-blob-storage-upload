FROM mcr.microsoft.com/azure-cli

LABEL "com.github.actions.name"="action-az-blob-storage-upload"
LABEL "com.github.actions.description"="Uploads assets to Azure Blob Storage"
LABEL "com.github.actions.icon"="box"
LABEL "com.github.actions.color"="green"
LABEL "repository"="https://github.com/ampeersenergy/action-az-blob-storage-upload"
LABEL "homepage"="https://github.com/ampeersenergy/action-az-blob-storage-upload"
LABEL "maintainer"="tb <t.bauchspiess@ampeersenergy.de>"

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
