#/bin/bash
block_dir=$azhpc_dir/experimental/blocks
AZHPC_CONFIG=config.json
AZHPC_VARIABLES=variables.json

blocks="$block_dir/vnet.json $block_dir/jumpbox.json $block_dir/cycle-install-server-managed-identity.json $block_dir/cycle-cli-local.json $block_dir/cycle-cli-jumpbox.json $block_dir/beegfs-cluster.json $azhpc_dir/examples/cc_beegfs/pbscycle.json"

# Initialize config file
echo "{}" >$AZHPC_CONFIG
$azhpc_dir/init-and-merge.sh "$blocks" $AZHPC_CONFIG $AZHPC_VARIABLES

echo "{}" >prereqs.json
prereqs="$block_dir/cycle-prereqs-managed-identity.json"
$azhpc_dir/init-and-merge.sh $prereqs prereqs.json $AZHPC_VARIABLES

# Update locker name
locker=$(jq -r '.variables.projectstore' $AZHPC_VARIABLES)
sed -i "s/#projectstore#/$locker/g" $AZHPC_CONFIG
