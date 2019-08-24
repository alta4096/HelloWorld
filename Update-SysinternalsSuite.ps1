function Update-SysinternalsSuite {
    param (
        [string]$pathsystinternalsuite
    )
    if (!$(test-path $pathsystinternalsuite) ){
        new-item -Path $pathsystinternalsuite -Force
        }
        
        Invoke-WebRequest -uri "https://download.sysinternals.com/files/SysinternalsSuite.zip" -OutFile "$pathsystinternalsuite\SysinternalsSuite.zip"
        Expand-Archive -Path "$pathsystinternalsuite\SysinternalsSuite.zip" -DestinationPath "$pathsystinternalsuite\SysinternalsSuite"
        Set-Location "$pathsystinternalsuite\SysinternalsSuite"
}



