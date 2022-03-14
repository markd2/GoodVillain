# GoodVillain

A casual game finally got me.  <A href="https://www.goodville.me">GoodVille</a> - a 
combination of psycholigically addictive gameplay that drives ad views and
mental health.  It's actually kind of fun, and has a through-story that's turning
out kind of weird (already seen some dead robbers and broken relationships among
the wheat growing and chicken minigames)

One thing it has is a crafting tree.  To make a window you need plywood that needs
vaneer and glue which need wood and corn respectively.  So when upgrading a building,
you need X amount of stuff, but it's hard to know "ok, **exactly** how much iron
do I need to do this upgrade?"

Inspired by [Andy Stefani](https://twitter.com/AndyStefani_)'s tuesday morning
[SwiftUI Meetup](https://events.lexgo.live/c/AL64i5aLUx6nm6JNi1M1), I'm getting
back into learning SwiftUI (again), hopefully using this as an App I'll actually
use and want to extend as time goes on.

### MVP

* ordered list of a subset of available craftables
* tap a craftable to add the components to another list along with all the components

That's going to involve ingesting the description of the craftables (probably YAML
(yay [Yams](https://github.com/jpsim/Yams)
because it's easy to edit), presenting stuff in a SwiftUI list, accumulate selections
int another SwiftUI list.  Button to reset things.

(yay - works!)

### Next Version

* categories (building, foods, etc)
* have a filter on the accumulator for "basic" supplies (e.g. how much iron do I really
  need for this upgrade?)
* calculate effective price of stuffs
* more compact UI
* figure out decent way of triggering reloads (probably will come after working through
  more of 100days of swiftom)

