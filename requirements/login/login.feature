# language: en
Feature: Login
Has a client
I would like to access the aplication with my account credentials,
so I can see a list of Tv channels and choose one to watch 

    Cenario: Invalid credentials
    At this point we know the user has provide correct username and password
    We should redirect the logged in user  to a list of channels and make 
    sure he/she is authenticated when running the aplication next time.

    Cenario: Valid credentials
    At this point we know the user has provide incorrect username or password
    And we show some error related to the failed authentication