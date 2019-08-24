#stolen from: https://www.ryandrane.com/2016/05/getting-ip-network-information-powershell/
# https://richardspowershellblog.wordpress.com/2010/05/09/bitwise-operations/
# http://www.padisetty.com/2014/05/powershell-bit-manipulation-and-network.html

function Convertto-Ipv4CIDR {
<#
.SYNOPSIS
Convert  IPv4 + Netmask to  CIDR format

.DESCRIPTION
Convert a IPv4 + a ipv4 Netmask to a CIDR format like "IPv4/IPv4Netmask"
with a regular expresion validation 

.PARAMETER Ipv4address
Specifies the Ipv4address like "10.10.10.10"

.PARAMETER Ipv4Netmask
Specifies the Netmask like "255.255.255.0"

.INPUTS
String for ipv4
String for IPv4 Netmask

.OUTPUTS
string
example:
"VERBOSE: 10.10.10.0/24"

.EXAMPLE
Convertto-Ipv4CIDR 10.10.10.10 -Ipv4Netmask 255.255.255.0
VERBOSE: 10.10.10.0/24

#>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true,ValueFromPipeline=$true,Position=0)]
        [ValidatePattern('^((25[0-5]|2[0-4]\d|[01]?\d\d?)\.){3}(25[0-5]|2[0-4]\d|[01]?\d\d?)$')]
        [System.Net.IPAddress]$Ipv4address,
        [Parameter(Mandatory=$true,ValueFromPipeline=$true,Position=1)]
        [ValidatePattern('^((25[0-5]|2[0-4]\d|[01]?\d\d?)\.){3}(25[0-5]|2[0-4]\d|[01]?\d\d?)$')]
        [System.Net.IPAddress]$Ipv4Netmask
    )
    
    begin {
        $Ipv4NetmaskBinary = $($Ipv4Netmask.GetAddressBytes() | ForEach-Object {[convert]::Tostring($_,2).padleft(8,"0")} ) -join ''
        if ($Ipv4NetmaskBinary.Split('0',2)[1] -match 1) {
             Write-Error -Message "Mask incorrect a 1 was between 0s" ; 
            Start-Sleep 5 ;
            Exit

        }
        if ($Ipv4NetmaskBinary.length -ne 32){
            Write-Error -Message "Mask has an incorrect length ,ipv4 has 32 only " ; 
            Start-Sleep 5 ;
            Exit
        }
    }
    
    process {
        [System.Net.IPAddress]$Ipv4SubnetResult = $Ipv4address.Address -band $Ipv4Netmask.Address 

         $Ipv4Result = $Ipv4SubnetResult.IPAddressToString + "/" + $Ipv4NetmaskBinary.IndexOf('0')
    }
    
    end {
        return $Ipv4Result
        Write-verbose -Message $Ipv4Result -Verbose
    }
}

#mask highest for ipv4 is /32
function  Convertfrom-Ipv4CIDR {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true,ValueFromPipeline=$true,Position=0)]
        [ValidatePattern('^((25[0-5]|2[0-4]\d|[01]?\d\d?)\.){3}(25[0-5]|2[0-4]\d|[01]?\d\d?)\/(25[0-5]|2[0-4]\d|[01]?\d\d?)$')]
        [String]$Ipv4CIDRInput
    )
    
    begin {
        [System.Net.IPAddress]$Ipv4Adress , [int16]$mask = $Ipv4CIDRInput -split ('/')
    }
    
    process {
      $binarymask =  [System.Convert]::ToString($mask,2).PadLeft(8,'0')
    }
    
    end {
    }
}

$mask2 = (-bnot [uint32]0) -shl (32 - $subnetlen)