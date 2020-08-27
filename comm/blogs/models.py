from django.db import models

from taggit.managers import TaggableManager
from helpers.models import BaseModel
from users.models import User
from .models import Category
class Post(BaseModel):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    title = models.CharField(max_length=255, blank=False)
    content = models.TextField()
    image = models.ImageField(blank=True, null=True)
    likes = models.ManyToManyField(User, related_name='likes', blank=True)
    category = models.ForeignKey(Category, verbose_name="Category")
    tags = TaggableManager()
    def total_likes(self):
        return self.likes.count()

    def __str__(self):
        return '%s - %s' % (self.id, self.title)

class Category(models.Model):
    name = models.CharField(max_length=200)
    slug = models.SlugField()
    parent = models.ForeignKey('self', blank=True, null=True, related_name='children',on_delete=models.CASCADE)

    class Meta:
        ordering = ('name',)
        verbose_name='category'
        verbose_name_plural ='category'
    def __str__(self):
        return '{}'.format(self.name)
class Comment(BaseModel):
    post = models.ForeignKey(Post, on_delete=models.CASCADE)
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    content = models.TextField()
    
    def __str__(self):
        return '%s - %s' % (self.id, self.user)
