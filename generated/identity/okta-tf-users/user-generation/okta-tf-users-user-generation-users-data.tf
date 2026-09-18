# Lookup of Okta user breanna.vanderplow by login
data "okta_user" "breanna_vanderplow" {
  provider    = okta.okta_tf_users
  skip_roles  = true
  skip_groups = true

  search {
    name       = "profile.login"
    value      = local.sensitive["email_breanna_vanderplow"]
    comparison = "eq"
  }
}
# Lookup of Okta user danishyo by login
data "okta_user" "danishyo" {
  provider    = okta.okta_tf_users
  skip_roles  = true
  skip_groups = true

  search {
    name       = "profile.login"
    value      = local.sensitive["email_danishyo"]
    comparison = "eq"
  }
}
# Lookup of Okta user hjyoo by login
data "okta_user" "hjyoo" {
  provider    = okta.okta_tf_users
  skip_roles  = true
  skip_groups = true

  search {
    name       = "profile.login"
    value      = local.sensitive["email_hjyoo"]
    comparison = "eq"
  }
}
# Lookup of Okta user james.brown by login
data "okta_user" "james_brown" {
  provider    = okta.okta_tf_users
  skip_roles  = true
  skip_groups = true

  search {
    name       = "profile.login"
    value      = local.sensitive["email_james_brown"]
    comparison = "eq"
  }
}
# Lookup of Okta user jason.ducker by login
data "okta_user" "jason_ducker" {
  provider    = okta.okta_tf_users
  skip_roles  = true
  skip_groups = true

  search {
    name       = "profile.login"
    value      = local.sensitive["email_jason_ducker"]
    comparison = "eq"
  }
}
# Lookup of Okta user joshua.franklin by login
data "okta_user" "joshua_franklin" {
  provider    = okta.okta_tf_users
  skip_roles  = true
  skip_groups = true

  search {
    name       = "profile.login"
    value      = local.sensitive["email_joshua_franklin"]
    comparison = "eq"
  }
}
# Lookup of Okta user katherine.powell by login
data "okta_user" "katherine_powell" {
  provider    = okta.okta_tf_users
  skip_roles  = true
  skip_groups = true

  search {
    name       = "profile.login"
    value      = local.sensitive["email_katherine_powell"]
    comparison = "eq"
  }
}
# Lookup of Okta user matthew.austin by login
data "okta_user" "matthew_austin" {
  provider    = okta.okta_tf_users
  skip_roles  = true
  skip_groups = true

  search {
    name       = "profile.login"
    value      = local.sensitive["email_matthew_austin"]
    comparison = "eq"
  }
}
# Lookup of Okta user michael.lalime by login
data "okta_user" "michael_lalime" {
  provider    = okta.okta_tf_users
  skip_roles  = true
  skip_groups = true

  search {
    name       = "profile.login"
    value      = local.sensitive["email_michael_lalime"]
    comparison = "eq"
  }
}
# Lookup of Okta user mykel.alvis by login
data "okta_user" "mykel_alvis" {
  provider    = okta.okta_tf_users
  skip_roles  = true
  skip_groups = true

  search {
    name       = "profile.login"
    value      = local.sensitive["email_mykel_alvis"]
    comparison = "eq"
  }
}
# Lookup of Okta user nnwogwu by login
data "okta_user" "nnwogwu" {
  provider    = okta.okta_tf_users
  skip_roles  = true
  skip_groups = true

  search {
    name       = "profile.login"
    value      = local.sensitive["email_nnwogwu"]
    comparison = "eq"
  }
}
# Lookup of Okta user p.maccready by login
data "okta_user" "p_maccready" {
  provider    = okta.okta_tf_users
  skip_roles  = true
  skip_groups = true

  search {
    name       = "profile.login"
    value      = local.sensitive["email_p_maccready"]
    comparison = "eq"
  }
}
# Lookup of Okta user patrick.tripp by login
data "okta_user" "patrick_tripp" {
  provider    = okta.okta_tf_users
  skip_roles  = true
  skip_groups = true

  search {
    name       = "profile.login"
    value      = local.sensitive["email_patrick_tripp"]
    comparison = "eq"
  }
}
# Lookup of Okta user porton by login
data "okta_user" "porton" {
  provider    = okta.okta_tf_users
  skip_roles  = true
  skip_groups = true

  search {
    name       = "profile.login"
    value      = local.sensitive["email_porton"]
    comparison = "eq"
  }
}
# Lookup of Okta user rick_luettich by login
data "okta_user" "rick_luettich" {
  provider    = okta.okta_tf_users
  skip_roles  = true
  skip_groups = true

  search {
    name       = "profile.login"
    value      = local.sensitive["email_rick_luettich"]
    comparison = "eq"
  }
}
# Lookup of Okta user rmarsool by login
data "okta_user" "rmarsool" {
  provider    = okta.okta_tf_users
  skip_roles  = true
  skip_groups = true

  search {
    name       = "profile.login"
    value      = local.sensitive["email_rmarsool"]
    comparison = "eq"
  }
}
# Lookup of Okta user william.mchale by login
data "okta_user" "william_mchale" {
  provider    = okta.okta_tf_users
  skip_roles  = true
  skip_groups = true

  search {
    name       = "profile.login"
    value      = local.sensitive["email_william_mchale"]
    comparison = "eq"
  }
}
# Lookup of Okta user yjzhang by login
data "okta_user" "yjzhang" {
  provider    = okta.okta_tf_users
  skip_roles  = true
  skip_groups = true

  search {
    name       = "profile.login"
    value      = local.sensitive["email_yjzhang"]
    comparison = "eq"
  }
}
# Lookup of Okta user zachary.wills by login
data "okta_user" "zachary_wills" {
  provider    = okta.okta_tf_users
  skip_roles  = true
  skip_groups = true

  search {
    name       = "profile.login"
    value      = local.sensitive["email_zachary_wills"]
    comparison = "eq"
  }
}