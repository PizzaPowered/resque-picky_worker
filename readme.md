# Resque::PickyWorker

Picky worker is a very opinionated worker that will just not be told what work to do. It prefers to pick and choose from the available queues, slotting in where it's needed to help others. Also kills itself quietly if left with no work to do.

## Developing

Requires redis running
