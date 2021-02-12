## Install Latest Version

With Shell:
```
$ curl https://get.k0s.io/install.sh | sh
```

With PowerShell:
```
> iwr -useb https://get.k0s.io/install.ps1 | iex
```

## Install Specific Version

With Shell:
```
$ curl https://get.k0s.io/install.sh | sh -s v0.0.12
```

With PowerShell:
```
> iwr https://get.k0s.io/install.ps1 -useb -outf install.ps1; .\install.ps1 v0.0.12
```

