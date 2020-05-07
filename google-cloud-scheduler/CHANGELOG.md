# Release History

### 2.0.0 / 2020-05-07

#### ⚠ BREAKING CHANGES

* **scheduler:** Convert google-cloud-scheduler to a wrapper gem

#### Features

* Convert google-cloud-scheduler to a wrapper gem

### 1.3.1 / 2020-04-01

#### Documentation

* Remove broken troubleshooting link from auth guide.

### 1.3.0 / 2020-03-11

#### Features

* Support separate project setting for quota/billing

### 1.2.1 / 2020-01-23

#### Documentation

* Update copyright year
* Update Status documentation

### 1.2.0 / 2019-11-04

This release requires Ruby 2.4 or later.

#### Bug Fixes

* Deprecate CloudSchedulerClient.project_path helper method

#### Documentation

* Clarify which Google Cloud Platform environments support automatic authentication
* Clarify required status of several fields

#### Other

* Update minimum runtime dependencies
* Update some network timeouts

### 1.1.2 / 2019-10-18

#### Documentation

* Update documentation with slight formatting and wording changes

### 1.1.1 / 2019-08-23

#### Documentation

* Update documentation

### 1.1.0 / 2019-07-08

* Support overriding service host and port.

### 1.0.1 / 2019-06-11

* Add VERSION constant

### 1.0.0 / 2019-05-24

* GA release
* Add Job#attempt_deadline
  * Add HttpTarget#authorization_header
  * Add HttpTarget#oauth_token (OAuthToken)
  * Add HttpTarget#oidc_token (OidcToken)

### 0.3.1 / 2019-04-29

* Add AUTHENTICATION.md guide.
* Update documentation for common types.

### 0.3.0 / 2019-04-15

* Add Job#attempt_deadline
* Add HttpTarget#oauth_token
* Add HttpTarget#oidc_token
* Add OAuthToken
* Add OidcToken
* Extract gRPC header values from request
* Update generated documentation

### 0.2.0 / 2019-03-12

* Add v1 api version

### 0.1.0 / 2018-12-13

* Initial release
