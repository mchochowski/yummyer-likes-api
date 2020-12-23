# Yummyer API

URL: https://yummyer-likes-api.herokuapp.com/

### Endpoints

#### POST /v1/liked_places

Allows marking a place as liked

Payload:

`username` - selected user

`liked_place[name]`

`liked_place[image_url]`

`liked_place[location]`

`liked_place[rating]`

`liked_place[yelp_id]`


Example request:

```
curl --location --request POST 'https://yummyer-likes-api.herokuapp.com/v1/liked_places' \
--form 'username="tuco-salamanca"' \
--form 'liked_place[yelp_id]="_sTaigaHcK8Pb1e-IcgGzw"' \
--form 'liked_place[name]="Jalapeños"' \
--form 'liked_place[image_url]="https://s3-media1.fl.yelpcdn.com/bphoto/Uf5_15yurBHiKOUK5HlXbg/o.jpg"' \
--form 'liked_place[location]="5714 5th Ave, Sunset Park, NY 11220"'
```

Example response:

```
{
    "data": {
        "id": "5fe3615d0c085c61c08ab669",
        "type": "place",
        "attributes": {
            "name": "Jalapeños",
            "image_url": "https://s3-media1.fl.yelpcdn.com/bphoto/Uf5_15yurBHiKOUK5HlXbg/o.jpg",
            "location": "5714 5th Ave, Sunset Park, NY 11220",
            "rating": null,
            "yelp_id": "_sTaigaHcK8Pb1e-IcgGzw",
            "_type": "LikedPlace"
        }
    }
}
```

#### POST /v1/disliked_places

Allows marking a place as disliked

Payload:

`username` - selected user

`liked_place[name]`

`liked_place[image_url]`

`liked_place[location]`

`liked_place[rating]`

`liked_place[yelp_id]`


Example request:

```
curl --location --request POST 'https://yummyer-likes-api.herokuapp.com/v1/disliked_places' \
--form 'username="tuco-salamanca"' \
--form 'liked_place[yelp_id]="_sTaigaHcK8Pb1e-IcgGzw"' \
--form 'liked_place[name]="Jalapeños"' \
--form 'liked_place[image_url]="https://s3-media1.fl.yelpcdn.com/bphoto/Uf5_15yurBHiKOUK5HlXbg/o.jpg"' \
--form 'liked_place[location]="5714 5th Ave, Sunset Park, NY 11220"'
```

Example response:

```
{
    "data": {
        "id": "5fe3615d0c085c61c08ab668",
        "type": "place",
        "attributes": {
            "name": "Jalapeños",
            "image_url": "https://s3-media1.fl.yelpcdn.com/bphoto/Uf5_15yurBHiKOUK5HlXbg/o.jpg",
            "location": "5714 5th Ave, Sunset Park, NY 11220",
            "rating": null,
            "yelp_id": "_sTaigaHcK8Pb1e-IcgGzw",
            "_type": "DislikedPlace"
        }
    }
}
```

#### GET /v1/liked_places

Lists liked places

Query parameters:

`username` - selected user

Example request:

https://yummuer-likes-api.herokuapp.com/v1/liked_places?username=tuco-salamanca

Example response:

```

```

#### GET /v1/disliked_places

Lists disliked places

Query parameters:

`username` - selected user

Example request:

https://yummuer-likes-api.herokuapp.com/v1/disliked_places?username=tuco-salamanca

Example response:

```

```
