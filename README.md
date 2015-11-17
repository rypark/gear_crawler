# :sparkles: :saxophone: Gear Crawler :guitar: :zap:

Example usage when running `rake console`:

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

Needs a lot of improvement, but you get the idea. It currently looks like so:

![screenshot](/docs/screenshot.png)
