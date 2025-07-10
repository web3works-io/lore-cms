FROM directus/directus:11.8.0

USER root
RUN corepack enable
# Add curl along with vim and jq
RUN apk add --no-cache vim jq curl bash
# Workaround for pnpm store issue in Directus 11.1.1 and later
RUN rm -rf /directus/node_modules/.modules.yaml
USER node

# Install axios
RUN pnpm add axios
RUN pnpm add dotenv
RUN pnpm add @directus/sdk
# Install directus-extension-api-docs
# Note: Extensions are typically installed in the extensions directory.
# This command installs it globally in the directus directory, which might not be the standard way
# for extensions. You might need to adjust this based on how the extension is intended to be installed.
# A more typical approach for extensions is to build them outside the container and copy them in.
# However, based on your request to 'npm install directus-extension-api-docs', this is the command.
# Consider consulting the directus-extension-api-docs documentation for the recommended installation method.
RUN pnpm add directus-extension-api-docs


COPY extensions /directus/extensions

