# Class: subversion
#
# Manage subversion checkouts
class subversion {

  if $::lsbdistcodename == 'hardy' {

    $pkg = "libneon27-gnutls_0.27.2-1ubuntu0.1_${::architecture}.deb"
    $pkg_name = 'libneon27-gnutls'

    package { 'subversion':
      ensure  => latest,
      require => Exec['install_libneon']
    }

    exec{'install_libneon':
      cwd     => '/tmp',
      command => "wget http://tools.softecspa.it/${pkg} && dpkg -i ${pkg} && rm ${pkg}",
      unless  => "dpkg -l ${pkg_name} | grep ^ii"
    }
  }
  else {
    package { 'subversion':
      ensure  => latest,
    }
  }
}
