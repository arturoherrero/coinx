# CoinX

Client to work with different Bitcoin Exchanges.

## TODO

- [x] Define project
- [x] Compile LibECP library automatically
- [x] Execute a WS call to the API without authentication
- [x] Subscribe to an event without authentication like watchOrders
- [ ] Execute a WS call to the API with authentication
- [ ] Subscribe to an event with authentication like getBalances
- [ ] Establish an architecture that allows to work with different exchange implementations
- [x] Create a CoinX client that subscribes to a topic setting a closure that is going to be called as a callback when an event occurs

## TASKS

- review event factory specs since probably there is a better way to test that with rspec
- review specific stubs created for coinfloor client specs since probably there is a better way to test that with rspec
- end to end tests + VCR
- proper dependency injection mechanism, do not call new inside a constructor

## IMPROVEMENTS

- [ ] Use non blocking calls
- [ ] Scheduler can be re-initialized every time there is a websocket communication

## NEXT STEPS

- [ ] Develop the trading algorithm as a separate project

## Contributors

- Arturo Herrero ([@ArturoHerrero][1])
- David Molinero ([@doktor500][2])


[1]: https://twitter.com/ArturoHerrero
[2]: https://twitter.com/doktor500
