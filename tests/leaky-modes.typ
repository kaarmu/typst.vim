= Leaky Bodies

== Issue #69

// Broken

#show link: underline
#show link: set text(navy)
#show par: set block(spacing: 1.75em)

// Not Broken

#show link: underline
#show link: set text(navy);;
#show par: set block(spacing: 1.75em)

== Issue #46 (solved)

// Not Broken 

#{ // Function body
  [ // Content block
  + text
  + text
  + #box()[text another text]
  + text
  + text
  ]
}

// Broken

#{ // Function body
  [ // Content block
  + text
  + text
  + #box()[text
    another text]
  + text
  + text
  ]
}

== Issue #43 (solved)

#while index < 3 {
    let x = "abc"  // Wrong highlighting
}

#{
    while index < 3 {
        let x = "abc"  // Correct highlighting
    }
}
