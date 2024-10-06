from django.urls import path
from .views import create_post
from .views import get_post
urlpatterns = [
   path("api/createpost", view = create_post, name = "create_post"),
   path("api/getpost", view = get_post, name = "get_post"),
]