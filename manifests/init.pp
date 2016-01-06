# Class: subversion
#
# Manage subversion checkouts
class subversion
{

  case $::lsbdistcodename {
    'hardy':
    {
      $pkg = "libneon27-gnutls_0.27.2-1ubuntu0.1_${::architecture}.deb"
      $pkg_name = 'libneon27-gnutls'
      exec{'install_libneon':
        cwd     => '/tmp',
        command => "wget http://tools.softecspa.it/${pkg} && dpkg -i ${pkg} && rm ${pkg}",
        unless  => "dpkg -l ${pkg_name} | grep ^ii"
      }->
      package { 'subversion':
        ensure  => latest,
      }
    }

    /^(lucid|precise)$/:
    {
      softec_apt::ppa { 'svn/ppa':
        mirror  => true,
        key     => 'A2F4C039'
      }->
      package { 'subversion':
        ensure  => latest,
      }
    }

    default:
    {
      package { 'subversion':
        ensure  => latest,
      }
    }
  }

}
