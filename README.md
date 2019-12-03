# GitHub Action to Upload Assets to Azure Blob Storage

This action is designed to use the [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest) to upload a directory of your choice to your Azure Blob Storage account.

## Usage

### Example

Place in a `.yml` file such as this one in your `.github/workflows` folder. [Refer to the documentation on workflow YAML syntax here.](https://help.github.com/en/articles/workflow-syntax-for-github-actions)

```yaml
name: Upload To Azure Blob Storage
on: push

jobs:
  upload:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@master
      - uses: bacongobbler/azure-blob-storage-upload@master
        with:
          source-dir: _dist
          connection-string: ${{ secrets.ConnectionString }}
          extra-args: '--pattern *.tar.gz*'
```

### Required Variables

| Key | Value |
| ------------- | ------------- |
| `source-dir` | The name of the directory you want to upload |
| `connection-string` | Your Azure Blob Storage connection string. |
| `extra-args` | extra arguments that can be passed to `az storage blob upload-batch`. Useful for passing flags like `--pattern` or `--destination-path`. |

## License

This project is distributed under the [MIT license](LICENSE.md).
