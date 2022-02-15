# Remote Authentication Use Case

## Success Case
1. ✅ The sistem has validate the data
2. The sistem make a request to user URL API endpoint 
3. The sistem validate the response data from the user API endpoint

## Exception - Invalid URL
1. The sistem returns an error (400) message

## Exception - Invalid data
1. The sistem returns an error (404) message


## Exception - Invalid response
1. The sistem returns an error message


## Exception - Server issues
1. The sistem returns an error (500) message

## Exceção - Invalid credentials
1. The sistem returns an error (401) with a message of invalid credentials