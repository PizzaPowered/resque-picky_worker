# Resque::PickyWorker

Picky worker is a very opinionated worker that will just not be told what work to do. It prefers to pick and choose from the available queues, slotting in where it's needed to help others.

Combined with a [fork of resque][resque-blocking] that uses a blocking redis command to fetch jobs and exits when there's no more jobs to process on that queue, plus [resque-pool][] to restart dead workers, you end up with a bunch of resque workers that can swarm on queues, work them till they are empty and then move on to other queues. Can also bring other data in from extensions like [resqueue-metadata][] to decide on max number of workers per queue for instance.

[resque-blocking]: https://github.com/PizzaPowered/resque/tree/blocking_reserve
[resqueue-metadata]: https://github.com/PizzaPowered/resqueue-metadata
[resque-pool]: https://github.com/nevans/resque-pool

## Installation

Install with rubygems (might need to run this as root, depending on your setup)

    gem install resque-picky_worker

Or in your Gemfile

    gem "resque-picky_worker"

## Usage

You'll need to require the picky worker, usually with `require "resque/picky_worker/override"` to make it the default Worker class in resque. (Means it Just Works™.)

Then you need to define how you want a queue to be chosen. Lets say we have a bunch of queues named after numbers and we want to choose the highest number available at the time the worker starts:

    Resque::PickyWorker.chooser = lambda { | queues | queues.map(&:to_i).max.to_s }

Then just fire up your resque workers as normal and they'll choose the highest queue available to listen to!

## MIT Licence

Copyright (c) 2011 PizzaPowered LLP <caius@pizzapowered.com>

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

See http://pizzapowered.com/ for contact details.
