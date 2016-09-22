Music Agents
=============================
The idea for this sort-of-game came out of thinking about ochestra dispositions, music composition and network functioning. 

In Music Agents, you can set up a number of Instruments, the Agents (which I like to think about as spies) that will randomly send each others messages. These messages contain a pitch and, on arrival, will make the receiver sound to it. The pitch is decided randomly from the Sender's pitch range.

Each agent has an Instrument, a Note, a Volume and a Pitch Range, which can be completely changed by the users to make their own compositions.

![Music Agents Screenshot](image_1.png)

Available instruments are: Chime, Small Chimes, Electric Strings (Double Bass), Nylon Strings, Violin and Short Violin.


Controls
-----------------------------------------------------
*Hand Tool* - Controls all aspects from agents. Left click will change the Instrument/Note/Volume/Pitch Max. or Min to their next level, and right click will take it to the previous level. The upper part of the pitch circle is the maximum and the lower part is the minimum. If they are equal, the pitch is fixed to that value.

*Add Agent* - Adds an agent to the point clicked on the scene. Any click works.

*Delete Agent* - Deletes the clicked agent.


How to execute it
-----------------------------------------------------
Just download the .zip from the release and execute the .exe! :D It currently only works for Windows, but contains both 32 and 64-bit versions. Both include the sounds, so no problem there =)

As for the raw code, you will need LÖVE2D 0.9.2 to run it (64 or 32 bit, depending on your computer). So far I haven't been able to upload the instruments for iterations 3 and 4. Having a look at *sound.lua* one can guess how folders have to be organized. Else, just PM me and I will send you a .zip.


License
-----------------------------------------------------
"Music Agents" is subjected to the LPGL v3 license.
