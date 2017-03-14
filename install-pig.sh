#!/bin/bash
###################################################################
# Pig Installation Script
# Pig version : 0.16.0
###################################################################


###################################################################
# Read environtment variables
###################################################################
source /opt/install-env.sh


###################################################################
# Extract pig to /opt/pig
###################################################################
tar xzf $PIG_INS -C $INSTALLATION_DIR
chown -R hduser:hadoop $PIG_DIR


###################################################################
# ----------------- Entering to hadoop user --------------------- #
###################################################################
su - hduser <<'EOF'


###################################################################
# Read environtment variables
###################################################################
source /opt/install-env.sh


###################################################################
# Add environment variables
###################################################################
cat <<EOT >> .bashrc

## PIG env variables
export PIG_INSTALL=$PIG_DIR
export PATH=\$PIG_INSTALL/bin:\$PATH
EOT

source .bashrc

EOF
###################################################################
# ---------------- End of hadoop user command ------------------- #
###################################################################
