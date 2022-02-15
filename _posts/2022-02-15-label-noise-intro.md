# Abstract

[Label noise intro + cleaning methods]

# Label Noise Introduction

[add a small intro]

## Classifying causes of intent label noise

| Type                             | Definition                                                                                                                                                                                    |
|----------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| human_error                      | Mistake while tagging. The gold tag is very obvious. This error can also be caused due to poor onboarding/misunderstanding among annotators. Further analysis on these errors maybe required. |
| audio_unclear (perception error) | Unable to understand the intent due to audio noise, low user speech volume, or unable to understand if it's a background speaker or the user speaking, etc.                                   |
| tool_problem                     | Audio could not be played, the problem with tagging interface, audio-clipping issue.                                                                                                          |
| onboarding_error                 | Intent Definition is confusing or bad or incomplete.                                                                                                                                          |
| multiple_intent                  | Audio contains multiple intents - in this case both the noisy and gold intents are correct.                                                                                                   |
| overlapping_intent               | Intent definitions are not mutually exclusive.                                                                                                                                                |
| renamed_intent                   | Intent renamed after guideline changes. This is not exactly a tagging error, but it’s helpful to capture changes.                                                                             |
| missing_context                  | Impossible to understand the intent unless more information is provided (bot prompt or previous state etc.)                                                                                   |
| wrong_retag                      | The new label after re-tagging is wrong.                                                                                                                                                      |


[add some examples for these tags]

# Why fix label noise?

[add Redoorz observation + importance of correcting benchmarks]

## Impact of train set label noise on model performance 


![image info](../assets/images/label-noise-blog/training_noise.png)

[add description]



# Minimizing tagging errors at source

* Onboarding session + 1-2 review session

* Tagging Guidelines
    [add info on mutual exclusivity and supporting tags, tradeoff between complexity and number of tags]

* Examples for exceptional cases - Tracking these would be helpful for designing/modifying intent definitions in the future. [add examples]

* Inter-annotator agreement type tagging is helpful for long-term test sets. Test sets serve as metrics for future plans and hence should have no label noise. Set up separate tog jobs for every annotator (2-3). Each instance would eventually get X tags (X is the number of annotators). [add reference]

# Different cleaning methods to fix label noise in train sets

### Random Sampling


### Biased Sampling

### Datamaps
* Threshold on label-score
* n-consecutive
* label noise classifier

### Cleanlab


# References