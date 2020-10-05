param(
    [string]
    $CertificateId = "CP-230012",

    [string]
    $VariableName = "EsrpJson",

    [Parameter(Mandatory)]
    [string]
    $SigningServer
)

$esrpParameters = @(
    @{
        ParameterName  = "OpusName"
        ParameterValue = "Microsoft"
    }
    @{
        ParameterName  = "OpusInfo"
        ParameterValue = "http://www.microsoft.com"
    }
    @{
        ParameterName  = "PageHash"
        ParameterValue = "/NPH"
    }
    @{
        ParameterName  = "FileDigest"
        ParameterValue = "/fd sha256"
    }
    @{
        ParameterName  = "TimeStamp"
        ParameterValue = "/tr ""$SigningServer"" /td sha256"
    }
)

$esrp = @(@{
    keyCode = $certificateId
    operationSetCode = "SigntoolSign"
    parameters = $esrpParameters
    toolName = "signtool.exe"
    toolVersion = "6.2.9304.0"
})

$vstsCommandString = "vso[task.setvariable variable=$VariableName][$($esrp | ConvertTo-Json -Compress)]"
Write-Verbose -Message ("sending " + $vstsCommandString) -Verbose
Write-Host "##$vstsCommandString"
