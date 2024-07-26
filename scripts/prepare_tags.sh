#!/bin/bash

CUSTOM_TAGS="${{ github.event.inputs.custom_tags }}"
GENERATED_TAGS="${{ steps.meta.outputs.tags }}"

# If CUSTOM_TAGS is empty, use GENERATED_TAGS
if [ -z "$CUSTOM_TAGS" ]; then
  echo "CUSTOM_TAGS=$GENERATED_TAGS" >> $GITHUB_ENV
  exit 0
fi

# Split the tags into arrays
IFS=',' read -r -a CUSTOM_TAG_ARRAY <<< "$CUSTOM_TAGS"
IFS=',' read -r -a GENERATED_TAG_ARRAY <<< "$GENERATED_TAGS"

# Generate new tags
NEW_TAGS=""
for GENERATED_TAG in "${GENERATED_TAG_ARRAY[@]}"; do
  BASE_TAG="${GENERATED_TAG%%:*}"
  for CUSTOM_TAG in "${CUSTOM_TAG_ARRAY[@]}"; do
    NEW_TAGS="$NEW_TAGS,$BASE_TAG:$CUSTOM_TAG"
  done
done

# Remove leading comma and set the new tags
NEW_TAGS="${NEW_TAGS#,}"
echo "CUSTOM_TAGS=$NEW_TAGS" >> $GITHUB_ENV
