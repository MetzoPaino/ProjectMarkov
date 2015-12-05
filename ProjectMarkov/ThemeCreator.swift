//
//  ThemeCreator.swift
//  ProjectMarkov
//
//  Created by William Robinson on 25/10/2015.
//  Copyright © 2015 William Robinson. All rights reserved.
//

import Foundation

func createHelloTheme() -> ThemeModel {
    
    let theme = ThemeModel(name: "Hello, is there anybody in there?")
    
    let helloPlaygroundMotif = MotifModel(string: "Hello, playground")
    let helloWorldMotif = MotifModel(string: "Hello, world")
    let lionelRichieMotif = MotifModel(string: "Hello, is it me your looking for")
    let theBeatlesMotif = MotifModel(string: "You say goodbye and I say hello")
    let allanShermanMotif = MotifModel(string: "Hello Mudda, hello fadda, here I am at Camp Granada.")
    let theDoorsMotif = MotifModel(string: "Hello, I love you, won't you tell me your name?")
    let simonAndGarfunkelMotif = MotifModel(string: "Hello, darkness, my old friend, I've come to talk with you again.")
    let pinkFloydMotif = MotifModel(string: "Hello, is there anybody in there?")
    let jerryMaguireMotif = MotifModel(string: "You had me at hello")
    let hannibalMotif = MotifModel(string: "Hello, Clarice")
    let ernieHarwellMotif = MotifModel(string: "It's time to say goodbye, but I think goodbyes are sad and I'd much rather say hello. Hello to a new adventure.")
    let jimiHendrixMotif = MotifModel(string: "The story of life is quicker than the blink of an eye, the story of love is hello, goodbye.")
    let robertPattinsonMotif = MotifModel(string: "Sometimes just when I say hello the right way, I'm like, Whoa, I'm so cool.")
    let carolineKnappMotif = MotifModel(string: "On the broad spectrum of solitude, I lean toward the extreme end: I work alone, as well as live alone, so I can pass an entire day without uttering so much as a hello to another human being. Sometimes a day's conversation consists of only five words, uttered at the local Starbucks: 'Large coffee with milk, please.'")
    let mindyKalingMotif = MotifModel(string: "You should never have to say hello or goodbye. Even at work sometimes, and I know this is very unpopular, is that if I'm going to work every single day, I don't think you should have to hug people hello every single day when you come to work. I saw you Monday!")
    let georgeGobelMotif = MotifModel(string: "When I go to a party, nobody says hello. But when I leave, everybody says goodbye.")
    let margaretNadauldMotif = MotifModel(string: "Standing as a witness in all things means being kind in all things, being the first to say hello, being the first to smile, being the first to make the stranger feel a part of things, being helpful, thinking of others' feelings, being inclusive.")
    let miguelMotif = MotifModel(string: "One of the most telling things about a person is how they say hello")
    let matthewMcconaugheyMotif = MotifModel(string: "The unsaid rule for living in a trailer park is: 'If the door's shut, don't come a-knockin.' But if it's open and you're walkin' by, feel free to say, 'Hello.'")
    let deanMartinMotif = MotifModel(string: "I've got seven kids. The three words you hear most around my house are 'hello', 'goodbye', and 'I'm pregnant'.")
    let brookeShieldsMotif = MotifModel(string: "Being nice to everybody, saying hello to everyone in the room, signing every autograph; it was instilled in me at a very young age that this was what I was suppose to do. But I don't think it helps at all. I see more people who are rude or arrogant being rewarded - but, this way, I can put my head on the pillow at night.")
    let henryRollinsMotif = MotifModel(string: "If you listen to the way I speak and watch the way I conduct myself - there's nothing about me that's rock n' roll. It's like, 'Hello, I'm in a rock n' roll band'. 'No, you're a narc.'")
    let normCrosbyMotif = MotifModel(string: "I met Elvis first in Las Vegas. I think I was appearing with Tom Jones and he came backstage to say hello to Tom or we went to his dressing room to say hello.")
    let laurelClarkMotif = MotifModel(string: "Hello from above our magnificent planet Earth.")
    let dakotaFanningMotif = MotifModel(string: "I think I was a Japanese schoolgirl in another life. That's how much I love Hello Kitty.")
    let venusWilliamsMotif = MotifModel(string: "I don't carry a purse when I fly because I have my Hello Kitty carry-on. I'm the biggest adult supporter.")
    let diabloCodyMotif = MotifModel(string: "I'm glad that as a 33-year-old working mother, I can still choose to wear a Hello Kitty T-shirt or stay up late scrolling through the Twitter feed of my junior-high crush.")
    let georgeForemanMotif = MotifModel(string: "So many of us have loved ones and people we really care about, and the only time we show affection is when they are gone. I have preached at funerals, and you see loved ones who didn't even say hello to dear ones when they were alive. Give them hugs, kisses while they are alive and need it.")
    let royOrbisonMotif = MotifModel(string: "As you stopped to say hello, oh, you wished me well, you couldn't tell that I'd been crying over you.")
    let joePesciMotif = MotifModel(string: "You don't say hello to Mr. DeNiro? Show the respect, will ya?")
    let avrilLavigneMotif = MotifModel(string: "I decorated my house like a medieval gothic castle, European-style. Chandeliers and red velvet curtains. My bedroom is pink and black, my bathroom is totally Hello Kitty, I have a massive pink couch and a big antique gold cross.")
    let hulkHoganMotif = MotifModel(string: "The only time I'm not Hulk Hogan is when I'm behind closed doors because as soon as I walk out the front door, and somebody says hello to me, I can't just say 'hello' like Terry. When they see me, they see the blond hair, the mustache, and the bald head, they instantly think Hulk Hogan.")
    let trevorDonovanMotif = MotifModel(string: "I graduated from school for graphic design, and I started to get into acting class just to get over severe fright. I was an extremely shy person. I could barely say hello to anybody.")
    let rossKempMotif = MotifModel(string: "I really hate people who feel their private lives should be paraded, and there are magazines like 'Hello!,' 'OK' and 'Bella' totally devoted to this.")
    let redBarberMotif = MotifModel(string: "This is Red Barber speaking. Let me say hello to you all.")
    
    theme.motifs = [helloPlaygroundMotif, helloWorldMotif, lionelRichieMotif, theBeatlesMotif, allanShermanMotif, theDoorsMotif, simonAndGarfunkelMotif, pinkFloydMotif, jerryMaguireMotif, hannibalMotif, ernieHarwellMotif, jimiHendrixMotif, robertPattinsonMotif, carolineKnappMotif, mindyKalingMotif, georgeGobelMotif, margaretNadauldMotif, miguelMotif, matthewMcconaugheyMotif, deanMartinMotif, brookeShieldsMotif, henryRollinsMotif, normCrosbyMotif, laurelClarkMotif, dakotaFanningMotif, venusWilliamsMotif, diabloCodyMotif, georgeForemanMotif, royOrbisonMotif, joePesciMotif, avrilLavigneMotif, hulkHoganMotif, trevorDonovanMotif, rossKempMotif, redBarberMotif]

    return theme
}

func createTheOldManAndTheSeaTheme() -> ThemeModel {

    let theme = ThemeModel(name: "The Old Man And The Sea")
    
    let motif1 = MotifModel(string: "How fresh they are and you down there six hundred feet in the cold water in the dark")
    let motif2 = MotifModel(string: "He was happy feeling the gentle pulling")
    let motif3 = MotifModel(string: "He did not even watch the big shark sinking slowly in the water, showing first life-size, then small, then tiny. That always fascinated the old man. But he did not even watch it now.")
    let motif4 = MotifModel(string: "“Something hurt him then,” he said aloud")
    let motif5 = MotifModel(string: "the heavy strong ones")

    theme.motifs = [motif1, motif2, motif3, motif4, motif5]
    
    return theme
}

func createMrsDallowayTheme() -> ThemeModel {
    
    let theme = ThemeModel(name: "Mrs Dalloway")
    
    let motif1 = MotifModel(string: "She heard the swish of Lucy's skirts, she felt like a nun who has left the world and feels fold round her the familiar veils and the response to old devotions")
    let motif2 = MotifModel(string: "Fields spread out and dark brown woods where adventurous thrushes, hopping boldly, glancing quickly, snatched the snail and tapped him on a stone, once, twice, thrice.")
    let motif3 = MotifModel(string: "So that anyone can stroll in and have a look at her where she lies with the brambles curving over her")
    let motif4 = MotifModel(string: "“Time flaps on the mast. There we stop; there we stand. Rigid, the Skelton of habit alone upholds the human frame.")
    let motif5 = MotifModel(string: "But there are tides in the body.")
    let motif6 = MotifModel(string: "Gently the yellow curtain with all the birds of Paradise blew out and it seemed as if there were a flight of wings into the room, right out, then sucked back.")
    
    theme.motifs = [motif1, motif2, motif3, motif4, motif5, motif6]
    
    return theme
}

func createConstellationTheme() -> ThemeModel {
    
    let theme = ThemeModel(name: "Constellation")

    let motif1 = MotifModel(string: "It grows in both directions")
    let motif2 = MotifModel(string: "And I felt doubt")
    let motif3 = MotifModel(string: "They came in vessels of bronze")
    let motif4 = MotifModel(string: "They grew from the dead")
    let motif5 = MotifModel(string: "A memory of having moved")
    let motif6 = MotifModel(string: "The moment of quickening")
    let motif7 = MotifModel(string: "The soul of a stone")
    let motif8 = MotifModel(string: "Trembling with contained energy")
    let motif9 = MotifModel(string: "All those who walked there became old")
    let motif10 = MotifModel(string: "Half forgotten, mostly ignored, half forgotten, partly ignored")
    let motif11 = MotifModel(string: "A temple of parting")
    let motif12 = MotifModel(string: "Nothing but a bone house")
    let motif13 = MotifModel(string: "A notion of presence")
    let motif14 = MotifModel(string: "I didn't hear them. I don't have a way to get them out.")
    let motif15 = MotifModel(string: "All the generations behind")
    let motif16 = MotifModel(string: "Once upon a tree he flew")
    let motif17 = MotifModel(string: "All of time and I could not see. only this dense field of uncertainty hung. And after all, it took was three steps forward toward where you stood.")
    let motif18 = MotifModel(string: "You spent time within the shade, the cool, the damp, the blind")
    let motif19 = MotifModel(string: "One of the four relics that fell from the sky in a chest")
    let motif20 = MotifModel(string: "Night house")
    let motif21 = MotifModel(string: "We are not very many, but we grow very old")
    let motif22 = MotifModel(string: "The wind held your hand as you walked")
    let motif23 = MotifModel(string: "Led home by a luxurious sunset")
    let motif24 = MotifModel(string: "Things that shine")
    let motif25 = MotifModel(string: "He begins at that end")
    let motif26 = MotifModel(string: "The gods were silent")
    let motif27 = MotifModel(string: "Buckled my joints")
    let motif28 = MotifModel(string: "Fourteen steps outside the space")
    let motif29 = MotifModel(string: "The mountain pierced the sky and the sun moaned")
    let motif30 = MotifModel(string: "I was made to carry heavy things")
    let motif31 = MotifModel(string: "The sower soweth the word")
    let motif32 = MotifModel(string: "The sower soweth the world")
    let motif33 = MotifModel(string: "Symbolic weight")
    let motif34 = MotifModel(string: "Night followed me home")
    let motif35 = MotifModel(string: "Infinite in age")
    let motif36 = MotifModel(string: "This is the place")
    let motif37 = MotifModel(string: "The world of longing")
    let motif38 = MotifModel(string: "Awake with context")
    let motif39 = MotifModel(string: "The forest awakes")
    
    theme.motifs = [motif1, motif2, motif3, motif4, motif5, motif6, motif7, motif8, motif9, motif10, motif11, motif12, motif13, motif14, motif15, motif16, motif17, motif18, motif19, motif20, motif21, motif22, motif23, motif24, motif25, motif26, motif27, motif28, motif29, motif30, motif31, motif32, motif33, motif34, motif35, motif36, motif37, motif38, motif39]
    
    return theme
}

func createTheOtherTheme() -> ThemeModel {
    
    let theme = ThemeModel(name: "The Other")
    
    let motif1 = MotifModel(string: "I heard the bad guy is me")
    let motif2 = MotifModel(string: "The monstrous female")
    let motif3 = MotifModel(string: "And it moved")
    let motif4 = MotifModel(string: "It's okay, it didn't hurt")
    let motif5 = MotifModel(string: "My kingdom in the corner")
    let motif6 = MotifModel(string: "It's a beast! It's a beast!")
    let motif7 = MotifModel(string: "No lingering syllables")
    let motif8 = MotifModel(string: "In the pitch of grief")
    let motif9 = MotifModel(string: "the abandoned child who should have stayed lost")
    let motif10 = MotifModel(string: "They hear about monsters that they will need to fight")
    let motif11 = MotifModel(string: "If I want to go back I need to crawl into it. I hate doing it, it's too small.")
    let motif12 = MotifModel(string: "A creature that bulged")
    let motif13 = MotifModel(string: "The beast is sitting up there")
    let motif14 = MotifModel(string: "And seemed to search for something on the ground")
    let motif15 = MotifModel(string: "The mask compelled them")
    let motif16 = MotifModel(string: "He did desperate violence to his naked body")
    let motif17 = MotifModel(string: "The doomed house of her flesh")
    let motif18 = MotifModel(string: "He rippled down the rock")
    let motif19 = MotifModel(string: "An open door invites shadows")
    let motif20 = MotifModel(string: "How the bodies form")
    let motif21 = MotifModel(string: "All sins are past")
    let motif22 = MotifModel(string: "God saw him when he was hid in the garden")
    
    theme.motifs = [motif1, motif2, motif3, motif4, motif5, motif6, motif7, motif8, motif9, motif10, motif11, motif12, motif13, motif14, motif15, motif16, motif17, motif18, motif19, motif20, motif21, motif22]
    
    return theme
}

func createSacksTheme() -> ThemeModel {
    
    let theme = ThemeModel(name: "Sacks")
    
    let motif1 = MotifModel(string: "His sense of the birds")
    let motif2 = MotifModel(string: "The relation of knowledge to perception")
    let motif3 = MotifModel(string: "Its head in the clouds")
    let motif4 = MotifModel(string: "Adds a special dimension")
    let motif5 = MotifModel(string: "A world of birds fly in and out")
    let motif6 = MotifModel(string: "He had divined a deeper truth")
    let motif7 = MotifModel(string: "Central resonances")
    let motif8 = MotifModel(string: "I am haunted by the density of reality")
    let motif9 = MotifModel(string: "Building a reality")
    let motif10 = MotifModel(string: "The objects of perception")
    let motif11 = MotifModel(string: "The context of an entire life")
    let motif12 = MotifModel(string: "Dimensions of this deficiency")
    let motif13 = MotifModel(string: "Mental representations of space")
    
    theme.motifs = [motif1, motif2, motif3, motif4, motif5, motif6, motif7, motif8, motif9, motif10, motif11, motif12, motif13]
    
    return theme
}

func createQuestionsTheme() -> ThemeModel {
    
    let theme = ThemeModel(name: "Questions")
    
    let motif1 = MotifModel(string: "Why do you care about stones?")
    let motif2 = MotifModel(string: "Does that make you sad?")
    let motif3 = MotifModel(string: "What have they seen?")
    let motif4 = MotifModel(string: "How deep is it?")
    let motif5 = MotifModel(string: "What if there was not just one tree, but a forest?")
    let motif6 = MotifModel(string: "Why and when did we start having this internal narrative?")
    let motif7 = MotifModel(string: "What's wrong?")
    let motif8 = MotifModel(string: "Are you pretending I'm someone else?")
    let motif9 = MotifModel(string: "Why do you ponder on such elements?")
    let motif10 = MotifModel(string: "How can you not see through such clear crystal?")
    
    theme.motifs = [motif1, motif2, motif3, motif4, motif5, motif6, motif7, motif8, motif9, motif10]
    
    return theme
}

func createDirectQuotesTheme() -> ThemeModel {
    
    let theme = ThemeModel(name: "Direct Quotes")
    
    let motif1 = MotifModel(string: "Trying to instil a sense of fight into a world you know you'll be leaving")
    let motif2 = MotifModel(string: "The product of turmoil in symmetry")
    let motif3 = MotifModel(string: "I've been diving for seventeen years and every day I find something new")
    let motif4 = MotifModel(string: "We got here because of a story and i don't want to lose that book")
    let motif5 = MotifModel(string: "Slowness was quite simply a theme granted by nature")
    let motif6 = MotifModel(string: "The excellence of everything slow")
    let motif7 = MotifModel(string: "Slowness is not an end in itself-neither a virtue not a defect")
    let motif8 = MotifModel(string: "My hunt is pleasing in the eyes of god")
    let motif9 = MotifModel(string: "A method in the exercise of slowness")
    let motif10 = MotifModel(string: "All forms of matter and energy exert a gravitational force, which in turn affects the path of light.")
    let motif11 = MotifModel(string: "They kept the candle from every cake lit in that house")
    let motif12 = MotifModel(string: "Down is very close to the ground")
    let motif13 = MotifModel(string: "You're inspired by what hasn't happened")
    let motif14 = MotifModel(string: "I've never met someone from a lost tribe who was lost")
    let motif15 = MotifModel(string: "I drew it when I was at my lowest ebb")
    let motif16 = MotifModel(string: "That wonderful sense of a year, of something cyclical")
    let motif17 = MotifModel(string: "The fossils were put in the box to give the appearance of ageing")
    let motif18 = MotifModel(string: "Made anxious by geologists")
    let motif19 = MotifModel(string: "It was condemned as magical thinking")
    let motif20 = MotifModel(string: "We had seen God in His splendours, heard the text that nature renders, We had reached the naked soul of man.")
    let motif21 = MotifModel(string: "I kissed your temples")
    
    theme.motifs = [motif1, motif2, motif3, motif4, motif5, motif6, motif7, motif8, motif9, motif10, motif11, motif12, motif13, motif14, motif15, motif16, motif17, motif18, motif19, motif20, motif21]
    
    return theme
}