# :sparkles: :saxophone: Gear Crawler :guitar: :zap:

One can never have enough used music equipment! There are several sites where used gear occasionally pops up for insanely cheap, some with nice notification systems, and some without (I'm looking at you, Guitar Center). This project is my attempt to consolidate these sites into one easily searchable system.

Example usage when running a barebones crawler via `rake console`:

```ruby
GuitarCenter.search('ludwig supraphonic').results
# Returns an array of results; a result looks like:
#
# <Crawler::Result:0x007f9a29306d10
#   @thumbnail="http://media.guitarcenter.com/is/image/MMGS7/1970s-5X14-Supraphonic-Snare-Drum/000000111597947-00-180x180.jpg",
#   @title="Vintage Ludwig 1970s 5X14 Supraphonic Snare Drum",
#   @href="http://www.guitarcenter.com/Used/Ludwig/Vintage-1970s-5X14-Supraphonic-Snare-Drum-111597947.gc",
#   @price=179.99,
#   @source="Guitar Center"
# >
```

Crawlers like the above are used within the sinatra app to search multiple sites and bring the results together on one page.

## Sinatra App Startup

`rerun 'ruby server.rb'`

## Cached Searching
By default, searches will be cached via VCR for 24 hours. To disable this feature and perform new searches every time, you can set `USE_VCR_CACHING` to false [here](/app/config/initializers/vcr_caching.rb#L4).


Needs a lot of improvement, but you get the idea. It currently looks like so:

![screenshot](/docs/screenshot.png)
