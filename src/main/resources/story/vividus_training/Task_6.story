Meta:
    @group VIVIDUS Training
    @requirementId MyTask-0006

Lifecycle:
Examples:
|userName	                |
|standard_user	            |
|performance_glitch_user	|

Scenario: Navigate to the SauceDemo website homepage
When I go to main application page

Scenario: Log in
When I log in as a user with registered username <userName> and password <password>
Then `${current-page-url}` is equal to `https://www.saucedemo.com/inventory.html`

Scenario: Add item to the shopping cart
When I wait until element located by `xpath(//a[@id="item_<itemPageId>_title_link"])` appears
Then text `<itemName>` exists
When I click on element located by `xpath(//button[@id="add-to-cart-<addToCartButtonId>"])`
Examples:
|itemName|itemPageId|addToCartButtonId|
|Sauce Labs Bolt T-Shirt|1|sauce-labs-bolt-t-shirt|
|Sauce Labs Backpack|4|sauce-labs-backpack|
|Sauce Labs Bike Light|0|sauce-labs-bike-light|

Scenario: Validate the num of items in the shopping cart
When I click on element located by `xpath(//a[@class="shopping_cart_link"])`
Then `${current-page-url}` is equal to `https://www.saucedemo.com/cart.html`
When I wait until element located by `xpath(//div[@class="cart_list"])` appears
Then number of elements found by `xpath(//div[@class="cart_quantity"])` is equal to `3`

Scenario: Log Out
When I reset app state
Then text `Sauce Labs Bolt T-Shirt` does not exist
Then text `Sauce Labs Backpack` does not exist
Then text `Sauce Labs Bike Light` does not exist
When I logged out
Then `${current-page-url}` is equal to `https://www.saucedemo.com/`
