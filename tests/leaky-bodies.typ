= Leaky Bodies

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
