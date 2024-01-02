import math
import io, time, json
import requests
from bs4 import BeautifulSoup

def retrieve_html(url):
    """
    Return the raw HTML at the specified URL.

    Args:
        url (string): 

    Returns:
        status_code (integer):
        raw_html (string): the raw HTML content of the response, properly encoded according to the HTTP headers.
    """
    ret_tuple = (requests.get(url).status_code, requests.get(url).text)
    
    return ret_tuple

def location_search_params(api_key, location, **kwargs):
    """
    Construct url, headers and url_params. Reference API docs (link above) to use the arguments
    """
    url = 'https://api.yelp.com/v3/businesses/search'
    auth = "Bearer " + api_key
    headers = {"Authorization": auth}
    # SPACES in url is problematic. How should you handle location containing spaces?
    location = location.strip()
    location = location.replace(" ", "+")
    url_params = {"location": location, **kwargs}
    
    return url, headers, url_params

def paginated_restaurant_search_requests(api_key, location, total):
    """
    Returns a list of tuples (url, headers, url_params) for paginated search of all restaurants
    Args:
        api_key (string): Your Yelp API Key for Authentication
        location (string): Business Location
        total (int): Total number of items to be fetched
    Returns:
        results (list): list of tuple (url, headers, url_params)
    """
    # HINT: Use total, offset and limit for pagination
    # You can reuse function location_search_params(...)
    all_requests_data = []
    
    for i in range(math.ceil(total/10)):
        generated_req_data = location_search_params(api_key, location, offset=i*10, limit=10, categories="restaurants")
        all_requests_data.append(generated_req_data)
    
    return all_requests_data
#     return 

def parse_api_response(data):
    """
    Parse Yelp API results to extract restaurant URLs.
    
    Args:
        data (string): String of properly formatted JSON.

    Returns:
        (list): list of URLs as strings from the input JSON.
    """
    
    json_arr = json.loads(data)
    
    urls = []
    
    for el in json_arr:
        urls.append(el['url'])

    return urls


def parse_page(html):
    """
    Parse the reviews on a single page of a restaurant.
    
    Args:
        html (string): String of HTML corresponding to a Yelp restaurant

    Returns:
        tuple(list, string): a tuple of two elements
            first element: list of dictionaries corresponding to the extracted review information
            second element: URL for the next page of reviews (or None if it is the last page)
    """
    soup = BeautifulSoup(html,'html.parser')
    url_next = soup.find('link',rel='next')
    if url_next:
        url_next = url_next.get('href')
    else:
        url_next = None

    reviews = soup.find_all('div', itemprop="review") 
    
    result = []
    found_data = {
        "authors_arr": None, 
        "ratings_arr": None,
        "dates_arr": None,
        "desc_arr": None
    }
    # find all meta data
    found_data['ratings_arr'] = soup.find_all('meta', itemprop="ratingValue")
    found_data['authors_arr'] = soup.find_all('meta', itemprop="author")
    found_data['desc_arr'] = soup.find_all('p', itemprop="description")
    found_data['dates_arr'] = soup.find_all('meta', itemprop="datePublished")
    
    # HINT: print reviews to see what http tag to extract
    for i in range(len(reviews)):
        # get vals
        author_val =  found_data['authors_arr'][i]['content']
        rating_val =  found_data['ratings_arr'][i]['content']
        date_val = found_data['dates_arr'][i]['content']
        desc_val = found_data['desc_arr'][i].get_text()
        # form a result entity
        result.append({
            'author': author_val,
            'rating': float(rating_val),
            'date': date_val,
            'description': desc_val
        })
        
    return result, url_next


# 4% credits
def extract_reviews(url, html_fetcher):
    """
    Retrieve ALL of the reviews for a single restaurant on Yelp.

    Parameters:
        url (string): Yelp URL corresponding to the restaurant of interest.
        html_fetcher (function): A function that takes url and returns html status code and content
    
    Returns:
        reviews (list): list of dictionaries containing extracted review information
    """
    result = []
    while True:
        code, html = html_fetcher(url)
        reviews_list, url_next = parse_page(html)
        # replace url_next
        url = url_next
        # add that reviews to our arr
        result = result + reviews_list
        # if no more url, then stop
        if url == None:
            break
    
    return result