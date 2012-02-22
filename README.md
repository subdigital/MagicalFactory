# Magical Factory

_(Note: this project is currently just a spike.  Use at your own risk)_

Magical Factory is a test object builder that simplifies creating objects for testing.
Its interface is inspired by [Factory Girl](http://github.com/thoughtbot/factory_girl) in the
Ruby community.

# Requirements

- Xcode 4.2+
- Test target SDK of 4.0 or greater

# Getting the code

You can clone the repository and build it separately from your project, or perhaps add it as a 
submodule.

Once you have the code you have a few options:

- Compile it once and take the static library
- Drag the classes into your project.  Make sure to link it only to your test target.
- Drag the project into your workspace.  Add libMagical-Factory.a as a dependency to your test target.

# Usage (proposed)

```objc

    // Given class Customer

    //defining factories
    [MFFactory defineFactoryForClass:[Customer class] withBlock:^(MFFactory *customer) {
       [customer sequenceFor:@"name" do:^(int i) {
           return @"Test Customer %d";
       }];

        [customer setStatus:@"active"];

        [customer sequenceFor:@"email" do:^(int i) {
            return @"customer-%d@example.com"
        ];
    }];

    //give me a customer
    Customer *testCustomer = [MFFactory buildObjectOfClass:[Customer class]];

    //named factories
    Customer *awesomeCustomer = [MFFactory buildObjectUsingFactory:@"awesome_customer"];

    // You can create a category method to make this a bit more friendly
    Customer *testCustomer = [MFFactory customer]; 

    //give me a customer with suspended status
    Customer *suspendedCustomer = [MFFactory buioldObjectOfClass:[Customer class] withParams:@{@"status":@"suspended"}];

```

## Known Limitations

The factory uses method forwarding to set properties on the subject.  Because of this, you'll get warnings
if your block defines the parameter as `MFFactory *`.  Instead, you can use `id` to supress the warnings.

Also, you cannot utilize properties, since they are not defined on `id`.

## Todo

- [done] Setting simple properties</strike>
- [done] Sequences
- Associations

## Contributing

Contributions are welcome.  Just fork the project, make your changes, submit a pull request.

Tests are appreciated :smile: .

# License (MIT)

Copyright (c) 2012 Ben Scheirman.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

