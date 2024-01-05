Meta:
    @group VIVIDUS Training
    @requirementId MyTask-0007

Lifecycle:
Examples:
|userName	                |password	    |
|standard_user	            |secret_sauce	|

Scenario: Navigate to the SauceDemo website homepage
Given I am on main application page
When I go to main application page
Then `${current-page-url}` is equal to `https://www.saucedemo.com/`

Scenario: Log in
When I log in as a user with registered username <userName> and password <password>
Then `${current-page-url}` is equal to `https://www.saucedemo.com/inventory.html`

Scenario: Add item to the shopping cart
When I wait until element located by `<itemPageId>` appears
Then text `<itemName>` exists
When I click on element located by `<addToCartButtonId>`
Examples:
|itemName|itemPageId|addToCartButtonId|
|Sauce Labs Bolt T-Shirt|xpath(//a[@id="item_1_title_link"])|xpath(//button[@id="add-to-cart-sauce-labs-bolt-t-shirt"])|

Scenario: Populate checkout data
When I open my Cart
Then `${current-page-url}` is equal to `https://www.saucedemo.com/cart.html`
When I wait until element located by `<buttonLocator1>` appears
Then number of elements found by `<buttonLocator2>` is equal to `1`
When I click on element located by `id(checkout)`
Then `${current-page-url}` is equal to `https://www.saucedemo.com/checkout-step-one.html`
When I enter `<firstName>` in field located by `id(first-name)`
When I enter `<lastName>` in field located by `id(last-name)`
When I enter `<postalCode>` in field located by `id(postal-code)`
When I take screenshot
Examples:
|buttonLocator1 |buttonLocator2|firstName|lastName|postalCode|
|xpath(//div[@class="cart_list"])|xpath(//div[@class="cart_quantity"])|#{generate(regexify '[0-9A-Za-z]{10}')}|#{generate(regexify '[A-Za-z]{15}')}|#{generate(regexify '[A-Z]{3}[-][0-9]{5}')}|

Scenario: Complete checkout process
When I click on element located by `id(continue)`
Then `${current-page-url}` is equal to `https://www.saucedemo.com/checkout-step-two.html`
When I click on element located by `id(finish)`
Then `${current-page-url}` is equal to `https://www.saucedemo.com/checkout-complete.html`
Then text `Thank you for your order!` exists
Given I initialize scenario variable `message1` with value `Thank you for your order!`
Given I initialize scenario variable `message2` with value `#{loadResource(/data/message.txt)}`
Then `${message1}` is = `${message2}`
