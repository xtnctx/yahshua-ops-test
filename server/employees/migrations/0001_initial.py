# Generated by Django 5.1.1 on 2024-10-04 13:56

import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Employees',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=150)),
                ('hourly_rate', models.IntegerField()),
            ],
        ),
        migrations.CreateModel(
            name='TimeLog',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('date', models.CharField(max_length=150)),
                ('time_in', models.CharField(max_length=150)),
                ('time_out', models.CharField(max_length=150)),
                ('employee', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='time_logs', to='employees.employees')),
            ],
        ),
    ]
