@{
    # opciones para el comportamiento de PSDepend
    PSDependOptions = @{
        Parameters = @{
            Import = $True
            SkipPublisherCheck = $True
            Repository = 'PSGallery'
        }
    }

    # ERROR: eliminar esta Hashtable para solucionar el error
    Error = @{
        Name = 'un-script-que-no-existe'
    }

    # modulos requeridos por el proceso CI/CD
    Pester = @{
        Name = 'pester'
        Version = 'latest'
    }

    PSScriptAnalyzer = @{
        Name = 'PSScriptAnalyzer'
        Version = 'latest'
    }    
}