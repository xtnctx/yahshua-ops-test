from django.db import models

class Employees(models.Model):
    name =  models.CharField(max_length=150)
    hourly_rate = models.IntegerField()
    date = models.CharField(max_length=150, blank=True, null=True)
    time_in = models.CharField(max_length=150, blank=True, null=True)
    time_out = models.CharField(max_length=150, blank=True, null=True)
    
    def __str__(self) -> str:
        return f'{self.name}'
