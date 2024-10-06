from django.shortcuts import render
from django.http import HttpResponse
from .serializers import PostSerializer
from rest_framework import status
from rest_framework.response import Response
from rest_framework.decorators import api_view
from .models import Post
# Create your views here.
@api_view(['POST'])
def create_post(request):
    if(request.method == "POST"):
        serializer = PostSerializer(data = request.data)
        if(serializer.is_valid()):
            serializer.save()
            return Response(serializer.data, status = status.HTTP_201_CREATED)
        return Response(serializer.errors, status = status.HTTP_400_BAD_REQUEST)

@api_view(['GET'])
def get_post(request):
    if(request.method == "GET"):
        posts = Post.objects.all()
        serializer = PostSerializer(posts, many = True)
        return Response(serializer.data)
    
