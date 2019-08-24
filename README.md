# Windows-Random

This is just a random repo related to Windows stuff.

- [Windows-Random](#windows-random)
  - [Microsoft.PowerShell_profile](#microsoftpowershellprofile)
  - [Convertto-Ipv4CIDR](#convertto-ipv4cidr)
  - [Update-sysinternals](#update-sysinternals)
  - [Remind me: Template for Comment based help](#remind-me-template-for-comment-based-help)
  - [Remind me: Template for Advanced Parameters](#remind-me-template-for-advanced-parameters)

## Microsoft.PowerShell_profile

Customization of a powershell profile.  Better versions:

<https://www.gngrninja.com/script-ninja/2016/3/20/powershell>
<https://hodgkins.io/ultimate-powershell-prompt-and-git-setup>
<https://thepracticalsysadmin.com/customize-your-powershell-profile/>

Great youtube Video:

Basic To Boss: Customizing Your PowerShell Prompt by Thomas Rayne
<https://www.youtube.com/watch?v=SdQYooRg7Cw>

## Convertto-Ipv4CIDR

help finding ipv4 CIDR mask from networkmask

In progress

## Update-sysinternals

Download and extract the file from the web

## Remind me: Template for Comment based help

Quick reminder of the comment based help.

<https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_comment_based_help?view=powershell-5.1>

```Powershell
<#
.SYNOPSIS

Adds a file name extension to a supplied name.

.DESCRIPTION

Adds a file name extension to a supplied name.
Takes any strings for the file name or extension.

.PARAMETER Name
Specifies the file name.

.PARAMETER Extension
Specifies the extension. "Txt" is the default.

.INPUTS

None. You cannot pipe objects to Add-Extension.

.OUTPUTS

System.String. Add-Extension returns a string with the extension
or file name.

.EXAMPLE

PS> extension -name "File"
File.txt

.EXAMPLE

PS> extension -name "File" -extension "doc"
File.doc

.EXAMPLE

PS> extension "File" "doc"
File.doc

.LINK

http://www.fabrikam.com/extension.html

.LINK

Set-Item
#>
```

## Remind me: Template for Advanced Parameters

Quick reminder of the Advanced Parameter based help.

<https://social.technet.microsoft.com/wiki/contents/articles/15994.powershell-advanced-function-parameter-attributes.aspx>

<https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_functions_advanced_parameters?view=powershell-5.1>

```Powershell
Parameter Attribute

Mandatory
Position
ParameterSetName
ValueFromPipeline
ValueFromPipelineByPropertyName
ValueFromRemainingArgument
HelpMessage
Alias

Parameter Validation Attributes

AllowNull
AllowEmptyString
AllowEmptyCollection
ValidateCount
ValidateLength
ValidatePattern
ValidateRange
ValidateScript
ValidateSet
ValidateNotNull
ValidateNotNullOrEmpty

Dynamic Parameters
Switch Parameters
```
