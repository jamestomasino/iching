# I Ching

This script will attempt to mimic the yarrow stalk method as close as possible without reducing logical steps or combining randomization.

Where mental focus and human choice are sought, the script will pause for user input waiting for intentions to be focused in the mind. When a key is pressed to continue the duration of the pause will become the seed of the next randomization choice to allow the user's action to influence the results.

## Psuedo-Code

- Start with 50 stalks.
- Set 1 aside

Begin Phase 1

- Focus the mind on the question posed to the oracle
- Split the stalks into two piles at some random proportion
- Remove 1 stalk from the right pile. Do not include in accumulator 1
- Mod 4 the left pile and store remainder in accumulator 1 (if result is 0, store 4)
- Mod 4 the right pile and store remainder in accumulator 1 (if result is 0, store 4)
- Accumulator total should be either 4 or 8.

Begin Phase 2

- Combine the remaining stalks from left and right piles (50 - 1 - 1 - accumulator 1)
- Focus the mind on the question posed to the oracle
- Split the stalks into two piles at some random proportion
- Remove 1 stalk from the right pile and include it in accumulator 2
- Mod 4 the left pile and store remainder in accumulator 2 (if result is 0, store 4)
- Mod 4 the right pile and store remainder in accumulator 2 (if result is 0, store 4)
- Accumulator total should be either 4 or 8.

Begin Phase 3

- Combine the remaining stalks from left and right piles (50 - 1 - 1 - accumulator 1 - accumulator 2)
- Focus the mind on the question posed to the oracle
- Split the stalks into two piles at some random proportion
- Remove 1 stalk from the right pile and include it in accumulator 3
- Mod 4 the left pile and store remainder in accumulator 3 (if result is 0, store 4)
- Mod 4 the right pile and store remainder in accumulator 3 (if result is 0, store 4)
- Accumulator total should be either 4 or 8.

Begin Phase 4

- For each accumulator score 2 points if the value is 4, 3 points if the value is 8
- The score determines the line type as follows:

```
6 points = Changing Yang   => Solid becomes Broken
7 points = Unchanging Yin  => Broken remains Broken
8 points = Unchanging Yang => Solid remains Solid
9 points = Changing Yin    => Broken becomes Solid
```

- Lines of the hexagrams are drawn from bottom to top
- Repeat this full process 6 times to draw the hexagram and its changed form
