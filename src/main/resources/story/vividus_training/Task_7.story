Meta:
    @group VIVIDUS Training
    @requirementId MyTask-0007

Lifecycle:
Examples:
|userName	                |
|standard_user	            |

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

Scenario: Populate checkout data
When I click on element located by `xpath(//a[@class="shopping_cart_link"])`
Then `${current-page-url}` is equal to `https://www.saucedemo.com/cart.html`
When I wait until element located by `xpath(//div[@class="cart_list"])` appears
Then number of elements found by `xpath(//div[@class="cart_quantity"])` is equal to `1`
When I click on element located by `id(checkout)`
Then `${current-page-url}` is equal to `https://www.saucedemo.com/checkout-step-one.html`
When I enter `#{generate(regexify '[A-Z]{1}[a-z]{7}')}` in field located by `id(first-name)`
When I enter `#{generate(regexify '[A-Z]{1}[a-z]{12}')}` in field located by `id(last-name)`
When I enter `#{generate(regexify '[A-Z]{3}[-][0-9]{5}')}` in field located by `id(postal-code)`
When I take screenshot

Scenario: Complete checkout process
When I click on element located by `id(continue)`
Then `${current-page-url}` is equal to `https://www.saucedemo.com/checkout-step-two.html`
When I click on element located by `id(finish)`
Then `${current-page-url}` is equal to `https://www.saucedemo.com/checkout-complete.html`
When I save text of element located by `xpath(//h2[@class="complete-header"])` to scenario variable `thankYouMessage1`
Given I initialize scenario variable `thankYouMessage2` with value `#{loadResource(/data/message.txt)}`
Then `#{eval(`${thankYouMessage1}` == `${thankYouMessage2}`)}` is = `true`
