# currencyfx

This is a sample application to support my [Getting Testy](http://randycoulman.com/blog/categories/getting-testy/) series of blog posts.

# Usage

To run the specs:

1. Clone this repository
2. Run `bundle` to install the necessary Ruby gems.
3. Run `bundle exec rake`

To run the application, you will need your own API key for the [Open Exchange Rates](https://openexchangerates.org/) API.

I've used the [dotenv gem]() to handle my API key so once you have your key, create a file in the root directory of the project named `.env` with the following contents:

```
OPEN_EXCHANGE_RATES_API_KEY="<<insert your api key here>>"
```

Once you've done that, you should be able to test out the command-line application as follows:

```
bundle exec bin/currencyfx --list
bundle exec bin/currencyfx 100 USD EUR
```

Let me know if you have any issues.
