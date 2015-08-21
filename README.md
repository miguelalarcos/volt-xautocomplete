# Volt::Xautocomplete

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'volt-xautocomplete'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install volt-xautocomplete

## Usage

```html
<:xautocomplete collection="{{store._authors}}" field="surname" value="{{page._surname}}" /> 
<:xautocomplete template='main/main/auto' collection="{{store._authors}}" field="surname" value="{{page._surname}}"  /> 
<:xautocomplete reference={{true}} collection="{{store._authors}}" field="surname" value="{{page._author}}" /> 
```

for the template option we need the file views/main/auto.html:

```html
<:Body>
    <b>{{attrs.data.text}}</b>
```

## Contributing

1. Fork it ( http://github.com/[my-github-username]/volt-xautocomplete/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
