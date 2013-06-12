# Goliath-Skeleton

Example app giving you a good foundation for building a robust API
service with Goliath, Grape, and Rabl.

See my original presentation at http://slidesha.re/18noOc3

## Author

Matt E. Patterson -- Digimonkey Studios (http://code.digimonkey.com)

## Installation

1. Get the code, put it on a server.
2. Configure stuff. see `config/application.rb` and `db/config.yml`
3. run `ruby app.rb -sv -p 9000` to make it go (on port 9000)!

## RABL Template Structure

My structure always starts with a `base.json.rabl` template for each resource. This is, essentially, the base set of things that will _always_ be displayed when a record of that resource is returned. From there, you should then create a specific template for each endpoint (see `index.json.rabl` and `show.json.rabl`) These extend the base and then bolt on any additional stuff you only want displayed for that particular request. As an example, I've setup this skeleton to only show :description on the #show endpoint for an Unlock.

## Localization

I've added basic localization support to this skeleton using Globalize3.

Basically, this just works by switching the I18n locale to whatever you send along with the request via the `locale` param. This should be a standard two-letter code (`en` for English, `de` for German, etc.) If you don't supply a `locale` param, it will default to English. If you supply a locale that the database has no translation for, it will fallback to English for that attribute.

To create a translation in a non-English locale, simply set I18n to your desired locale and then update the attribute via ActiveRecord as normal. It won't mess with your default (English)... it will only modify the translation for that locale. See https://github.com/svenfuchs/globalize3 for more on how that all works.

Because the localization trick works in the `before..end` block that runs ahead of _every_ endpoint request, if you add #create and #update endpoints, this will just automagically work. Create a record with no supplied `locale` param and it will save everything as English. Then update that along with a `locale` param and it will add the translations you've specified. Simple!

GOTCHA: When you write a migration to create a new table, if that table is going to have any translated fields, you'll need to add the associated `Klass.create_translation_table(...)` bit. See my example Unlocks migration. There is also a relatively undocumented `add_translation_fields!` if you need to add some new translation fields in a later migration. See https://github.com/svenfuchs/globalize3/issues/98

## Error Handling

My example automatically intercepts any exceptions that occur in the Goliath app. Instead of just crashing the process, this results in the app logging a FATAL with all the pertinent info and then throwing a Rack response with that same info. This may or may not be the desired behavior, depending on how you intend for this API to work within your own infrastructure.