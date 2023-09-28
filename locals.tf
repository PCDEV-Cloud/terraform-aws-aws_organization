locals {
  accounts = { for i in var.accounts : i.name => i }

  services = var.services["all"] ? [for i, k in var.services : lookup(local.service_access_principals, i, "")] : compact([for i, k in var.services : lookup(local.service_access_principals, i, "") if k])

  # https://docs.aws.amazon.com/organizations/latest/userguide/orgs_integrate_services_list.html
  service_access_principals = {
    account_management            = "account.amazonaws.com"
    application_migration_service = "mgn.amazonaws.com"
    artifact                      = "artifact.amazonaws.com"
    audit_manager                 = "auditmanager.amazonaws.com"
    backup                        = "backup.amazonaws.com"
    cloudformation_stacksets      = "stacksets.cloudformation.amazonaws.com"
    cloudtrail                    = "cloudtrail.amazonaws.com"
    compute_optimizer             = "compute-optimizer.amazonaws.com"
    config                        = "config.amazonaws.com"
    control_tower                 = "controltower.amazonaws.com"
    detective                     = "detective.amazonaws.com"
    devops_guru                   = "devops-guru.amazonaws.com"
    directory_service             = ""
    firewall_manager              = "fms.amazonaws.com"
    guardduty                     = "guardduty.amazonaws.com"
    health                        = "health.amazonaws.com"
    access_analyzer               = ""
    inspector                     = "inspector2.amazonaws.com"
    license_manager               = "license-manager.amazonaws.com"
    macie                         = "macie.amazonaws.com"
    marketplace                   = "license-management.marketplace.amazonaws.com"
    network_manager               = ""
    resource_access_manager       = "ram.amazonaws.com"
    security_hub                  = ""
    s3_storage_lens               = "storage-lens.s3.amazonaws.com"
    security_lake                 = "securitylake.amazonaws.com"
    service_catalog               = "servicecatalog.amazonaws.com"
    service_quotas                = ""
    iam_identity_center           = "sso.amazonaws.com"
    systems_manager               = "ssm.amazonaws.com"
    tag_policies                  = "tagpolicies.tag.amazonaws.com"
    trusted_advisor               = "reporting.trustedadvisor.amazonaws.com"
    well_architected_tool         = "wellarchitected.amazonaws.com"
    vpc_ip_address_manager        = "ipam.amazonaws.com"
    vpc_reachability_analyzer     = "reachabilityanalyzer.networkinsights.amazonaws.com"
    # cloudwatch_events              = ""
    # identity_and_access_management = ""
  }
}