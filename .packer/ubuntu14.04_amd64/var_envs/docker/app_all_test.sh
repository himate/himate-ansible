### ANSIBLE SETTINGS
export PACKER_ANSIBLE_GROUPS='app,app_test,test'
export PACKER_IMG_SPEC='test_all'
export PACLER_HOST_NAME='app-all-test'

### APP SETTINGS
export PACKER_APP_TYPES='["customer", "merchant", "admin"]'
export PACKER_APP_CUSTOMER_DOMAIN='app-test.himate.org'
export PACKER_APP_MERCHANT_DOMAIN='merchant-test.himate.org'
export PACKER_APP_ADMIN_DOMAIN='admin-test.himate.org'
