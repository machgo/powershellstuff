$XmlFile = Get-Item('VPN_Profile.xml')
$XmlSchema = Get-Item('profile.xsd')

$readerSettings = New-Object -TypeName System.Xml.XmlReaderSettings
$readerSettings.Schemas.Add($null, $XmlSchema.Fullname)
$readerSettings.ValidationType = [System.Xml.ValidationType]::Schema
$readerSettings.ValidationFlags = [System.Xml.Schema.XmlSchemaValidationFlags]::ProcessInlineSchema -bor [System.Xml.Schema.XmlSchemaValidationFlags]::ProcessSchemaLocation
$readerSettings.add_ValidationEventHandler(
{
    Write-Host $("ERROR line $($_.exception.LineNumber) position $($_.exception.LinePosition) in '$xmlFileName': " + $_.Message) -ForegroundColor Red
    $script:errorCount++
});
$reader = [System.Xml.XmlReader]::Create($XmlFile.FullName, $readerSettings)
while ($reader.Read()) { }
$reader.Close()