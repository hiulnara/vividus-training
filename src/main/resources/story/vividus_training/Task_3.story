Scenario: Navigate to the SauceDemo website homepage
Given I am on main application page
When I go to main application page
Then `${current-page-url}` is equal to `https://www.saucedemo.com/`


Scenario: Log in as a Good User
When I log in as a user with registered username ${swagGoodUserName} and password ${swagPassword}
Then `${current-page-url}` is equal to `https://www.saucedemo.com/inventory.html`
When I logged out

Scenario: Log in as a Broken User
When I log in as a user with registered username ${swagBrokenUserName} and password ${swagPassword}
Then `${current-page-url}` is equal to `https://www.saucedemo.com/inventory.html`
When I logged out

Scenario: Log in as a Slow User
When I log in as a user with registered username ${swagSlowUserName} and password ${swagPassword}
Then `${current-page-url}` is equal to `https://www.saucedemo.com/inventory.html`
When I logged out

Scenario: Try to log in as a Locked User
When I log in as a user with registered username ${swagLockedUserName} and password ${swagPassword}
Then text `Epic sadface: Sorry, this user has been locked out.` exists
