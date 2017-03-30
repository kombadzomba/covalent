#!/bin/bash
#scope=@enelit

#login into private registry
npm login --scope=@enelit
npm publish ./deploy/platform/core --access=public

#logout when finished
npm logout 
echo "Published successfully. Use 'npm install [package-name]' in the project you want to use it."
