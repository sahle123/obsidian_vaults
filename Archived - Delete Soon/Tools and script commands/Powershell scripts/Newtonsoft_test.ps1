for($i = 0; $i -lt 3; $i++)
{
	Invoke-RestMethod -Uri http://localhost:55001/api/master/TEST/data/Newtonsoft_GetAllIcdCodes/
	Write-Host $i
}