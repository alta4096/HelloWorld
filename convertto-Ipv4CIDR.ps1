function Convertto-Ipv4CIDR {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true,ValueFromPipeline=$true,Position=0)]
        [ValidatePattern('^((25[0-5]|2[0-4]\d|[01]?\d\d?)\.){3}(25[0-5]|2[0-4]\d|[01]?\d\d?)$')]
        [System.Net.IPAddress]$Ipv4address,
        [Parameter(Mandatory=$true,ValueFromPipeline=$true,Position=1)]
        [ValidatePattern('^((25[0-5]|2[0-4]\d|[01]?\d\d?)\.){3}(25[0-5]|2[0-4]\d|[01]?\d\d?)$')]
        [System.Net.IPAddress]$Ipv4mask
    )
    
    begin {
        $Ipv4maskBinary = $($Ipv4mask.GetAddressBytes() | ForEach-Object {[convert]::Tostring($_,2).padleft(8,"0")} ) -join ''
        if ($Ipv4maskBinary.Split('0',2)[1] -match 1) {
             Write-Error -Message "Mask incorrect a 1 was between 0s " ; 
            Start-Sleep 5 ;
            Exit

        }
        if ($Ipv4maskBinary.length -ne 32){
            Write-Error -Message "Mask has an incorrect length ,ipv4 has 32 only " ; 
            Start-Sleep 5 ;
            Exit
        }
    }
    
    process {
        [System.Net.IPAddress]$Ipv4SubnetResult = $Ipv4address.Address -band $Ipv4mask.Address 

         $Ipv4Result = $Ipv4SubnetResult.IPAddressToString + "/" + $Ipv4maskBinary.IndexOf('0')
    }
    
    end {
        Write-verbose -Message $Ipv4Result -Verbose
    }
}