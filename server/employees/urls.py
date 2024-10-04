from django.urls import path, include
from . import views

urlpatterns = [
    path('all/', views.EmployeeListView.as_view(), name='all_employees'),
    path('<int:pk>/', views.EmployeeDetailView.as_view(), name='employee'),
    path('create/', views.EmployeeCreateView.as_view(), name='create_employee'),
]