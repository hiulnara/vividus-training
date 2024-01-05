Meta:
    @group VIVIDUS Training
    @requirementId MyTask-0006

Lifecycle:
Examples:
|userName	                |password	    |
|standard_user	            |secret_sauce	|
|performance_glitch_user	|secret_sauce	|

Scenario: Navigate to the SauceDemo website homepage
Given I am on main application page
When I go to main application page
Then `${current-page-url}` is equal to `https://www.saucedemo.com/`

Scenario: Log in
When I log in as a user with registered username <userName> and password <password>
Then `${current-page-url}` is equal to `https://www.saucedemo.com/inventory.html`

Scenario: Add 3 items to the shopping cart
When I wait until element located by `<itemPageId>` appears
Then text `<itemName>` exists
When I click on element located by `<addToCartButtonId>`
Examples:
|itemName|itemPageId|addToCartButtonId|
|Sauce Labs Bolt T-Shirt|xpath(//a[@id="item_1_title_link"])|xpath(//button[@id="add-to-cart-sauce-labs-bolt-t-shirt"])|
|Sauce Labs Backpack|xpath(//a[@id="item_4_title_link"])|xpath(//button[@id="add-to-cart-sauce-labs-backpack"])|
|Sauce Labs Bike Light|xpath(//a[@id="item_0_title_link"])|xpath(//button[@id="add-to-cart-sauce-labs-bike-light"])|


Scenario: Validate the num of items in the shopping cart
When I open my Cart
Then `${current-page-url}` is equal to `https://www.saucedemo.com/cart.html`
When I wait until element located by `<buttonLocator1>` appears
Then number of elements found by `<buttonLocator2>` is equal to `3`
Examples:
|buttonLocator1 |buttonLocator2|
|xpath(//div[@class="cart_list"])|xpath(//div[@class="cart_quantity"])|


Scenario: Log Out
When I reset app state
Then text `<cartItemName1>` does not exist
Then text `<cartItemName2>` does not exist
Then text `<cartItemName3>` does not exist
When I logged out
Then `${current-page-url}` is equal to `https://www.saucedemo.com/`
Examples:
|cartItemName1|cartItemName2|cartItemName3|
|Sauce Labs Bolt T-Shirt|Sauce Labs Backpack|Sauce Labs Bike Light|
