from rest_framework.response import Response
from rest_framework.views import APIView
from . serializers import EmployeesSerializer
from rest_framework import status
from . models import Employees
from rest_framework import generics
from django.shortcuts import get_object_or_404


    
class EmployeeListView(generics.ListAPIView):
    queryset = Employees.objects.all()
    serializer_class = EmployeesSerializer

    def get(self, request):
        books = self.get_queryset()
        serializer = self.get_serializer(books, many=True)
        return Response(serializer.data, status=status.HTTP_200_OK)

    
class EmployeeCreateView(APIView):
    def post(self, request):
        # date = request.data.get('date'),
        # time_in = request.data.get('time_in'),
        # time_out = request.data.get('time_out'),

        data = {
            'name': request.data.get('name'),
            'hourly_rate': request.data.get('hourly_rate'),
            'date': request.data.get('date'),
            'time_in': request.data.get('time_in'),
            'time_out': request.data.get('time_out'),
        }
        serializer = EmployeesSerializer(data=data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    
    def put(self, request):
        employee_id = request.data.get('employee_id')
        name = request.data.get('name')
        hourly_rate = request.data.get('hourly_rate')
        date = request.data.get('date')
        time_in = request.data.get('time_in')
        time_out = request.data.get('time_out')

        Employees.objects.filter(id=employee_id).update(
            name=name, hourly_rate=hourly_rate, 
            date=date, time_in=time_in, time_out=time_out
        )
        return Response({"success": True}, status=status.HTTP_201_CREATED)


class EmployeeDetailView(generics.RetrieveAPIView):
    queryset = Employees.objects.all()
    serializer_class = EmployeesSerializer

    def delete(self, request, pk):
        employee = get_object_or_404(Employees, pk=pk)
        employee.delete()
        return Response({"deleted": True})

    