#!/bin/python3

import requests

response = requests.get("https://www.google.com")

#print(response.status_code)

#print(response.headers)

print(response.cookies)