Meta:
    @group VIVIDUS Training
    @requirementId MyTask-0008

Lifecycle:
Examples:
|userName      |
|standard_user |

Scenario: Navigate to the SauceDemo website homepage
When I go to main application page
When I ${baselineAction} baseline with name `loginPage` ignoring:
|ACCEPTABLE_DIFF_PERCENTAGE|
|10                        |

Scenario: Log in
When I log in as a user with registered username <userName> and password <password>
Then `${current-page-url}` is equal to `https://www.saucedemo.com/inventory.html`


Scenario: Add items to the shopping cart
When I select `<sortingValue> (low to high)` in dropdown located by `xpath(//select[@class="product_sort_container"])`
When I click on element located by `xpath(//div[@class="inventory_item"][1]//button[contains(@class, "btn_primary")][1])`
When I select `<sortingValue> (high to low)` in dropdown located by `xpath(//select[@class="product_sort_container"])`
When I click on element located by `xpath(//div[@class="inventory_item"][1]//button[contains(@class, "btn_primary")][1])`
When I save text of element located by `xpath(//a/span[1])` to scenario variable `cartCount`
Then `${cartCount}` is = `<cartBadgeCount>`
Examples:
|sortingValue|cartBadgeCount|
|Price      |2             |


Scenario: Populate checkout data
When I click on element located by `xpath(//a[@class="shopping_cart_link"])`
Then `${current-page-url}` is equal to `https://www.saucedemo.com/cart.html`
When I wait until element located by `xpath(//div[@class="cart_list"])` appears
Then number of elements found by `xpath(//div[@class="cart_quantity"])` is equal to `2`
When I click on element located by `id(checkout)`
Then `${current-page-url}` is equal to `https://www.saucedemo.com/checkout-step-one.html`
When I enter `#{generate(regexify '[A-Z]{1}[a-z]{7}')}` in field located by `id(first-name)`
When I enter `#{generate(regexify '[A-Z]{1}[a-z]{12}')}` in field located by `id(last-name)`
When I enter `#{generate(regexify '[A-Z]{3}[-][0-9]{5}')}` in field located by `id(postal-code)`
When I ${baselineAction} baseline with name `checkoutPage` ignoring:
|ELEMENT                              |AREA                          |ACCEPTABLE_DIFF_PERCENTAGE|
|By.xpath(//*[@class="checkout_info"])|By.cssSelector(.checkout_info)|50                        |


Scenario: Validate order summary and complete order
When I click on element located by `id(continue)`
Then `${current-page-url}` is equal to `https://www.saucedemo.com/checkout-step-two.html`
When I save text of element located by `xpath(//div[@class="cart_item"][1]//div[@class="inventory_item_price"][last()])` to scenario variable `SumOfCheapestItem`
When I save text of element located by `xpath(//div[@class="cart_item"][2]//div[@class="inventory_item_price"][last()])` to scenario variable `SumOfExpensiveItem`
When I save text of element located by `xpath(//div[@class="summary_subtotal_label"])` to scenario variable `totalPrice`
Given I initialize scenario variable `SumOfCheapestItemNum` with value `#{substringAfter(${SumOfCheapestItem}, $)}`
Given I initialize scenario variable `SumOfExpensiveItemNum` with value `#{substringAfter(${SumOfExpensiveItem}, $)}`
Given I initialize scenario variable `totalPriceNum` with value `#{substringAfter(${totalPrice}, Item total: $)}`
Then `#{round(#{eval(${SumOfCheapestItemNum} + ${SumOfExpensiveItemNum})}, 2, half up)}` is = `#{round(${totalPriceNum}, 2, half up)}`
When I ${baselineAction} baseline with name `cartItems` ignoring:
|ELEMENT                          |AREA                      |ACCEPTABLE_DIFF_PERCENTAGE|
|By.xpath(//*[@class="cart_item"])|By.cssSelector(.cart_item)|50                        |
When I click on element located by `id(finish)`
Then `${current-page-url}` is equal to `https://www.saucedemo.com/checkout-complete.html`
When I save text of element located by `xpath(//h2[@class="complete-header"])` to scenario variable `thankYouMessage`
Then `${thankYouMessage}` is equal to `Thank you for the order!`
