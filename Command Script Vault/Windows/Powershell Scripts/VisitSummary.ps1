$port = 55003;
$body = @{
	"patientMRN"= 3458016;
	"appointmentNo"= 171;
	"episodeId"= 200011031;
} | ConvertTo-Json;

# Visit Summary
for($i = 0; $i -lt 50; $i++)
{
	Invoke-RestMethod -Uri http://localhost:$port/api/medicalrecord/visitsummary -Method POST -Body $body -ContentType "application/json";
	Write-Host $i;
};
# Visit Summary 2
for($i = 0; $i -lt 50; $i++)
{
	Invoke-RestMethod -Uri http://localhost:$port/api/medicalrecord/visitsummary2 -Method POST -Body $body -ContentType "application/json";
	Write-Host $i;
};
# Visit Summary
for($i = 0; $i -lt 50; $i++)
{
	Invoke-RestMethod -Uri http://localhost:$port/api/medicalrecord/visitsummary -Method POST -Body $body -ContentType "application/json";
	Write-Host $i;
};
# Visit Summary 2
for($i = 0; $i -lt 50; $i++)
{
	Invoke-RestMethod -Uri http://localhost:$port/api/medicalrecord/visitsummary2 -Method POST -Body $body -ContentType "application/json";
	Write-Host $i;
};