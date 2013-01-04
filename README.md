# foodpron.com
show the best images of #foodpron and #foodporn from twitter

## technology
I made foodpron to play around with various technologies.

### finding foodpron
1. use twitter gem to find tweets about foodpron
2. follow any links in the tweet (usually to instagram)
3. locate largest image on each of the pages from step 2 and post them to foodpron

### sinatra
Sinatra is used to create a really simple web API for posting new images, checking scores, and viewing the current image.

### redis
there is one data model, an image, stored as a sorted set in redis.