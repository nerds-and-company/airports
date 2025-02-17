# Changelog

## 1.1.0

- Update README
- Update airports & timezone csv by running `mix airports.update`
- Auto download source file when running `mix airports.update`
- Bump dependencies: `excoveralls`, `castore`, `ex_doc`, and `dialyxir`

## 1.0.0

- **Breaking change:** Swapped to new airports datasource as old has not been [updated since 2019](https://github.com/jpatokal/openflights/commits/master/data/airports.dat) where as the new source (which is listed on the openflights website) is [updated daily(!)](https://github.com/davidmegginson/ourairports-data/commits/main/airports.csv)
- Added dependabot
- Added Github Actions
- Swap csv for nimble_csv
- Add timezone information accessible through the `timezone_id` field on the `Airport` struct
- Set `skip_headers: true` when parsing airports from source file

## 0.1.0

- Initial Release
