proc processFile {filename} {
    if {![file exists $filename]} {
        return "File not found: $filename"
        exit
    }

    set infile [open $filename r]
    
    set calorie 0
    set rucksacks [lmap line [split [read $infile] "\n"] {
        set weight [string trim $line]
        if {[string is integer -strict $weight]} {
            incr calorie $weight
            continue
        } 
        set value $calorie
        set calorie 0
        set value
    }]
    close $infile

    lassign [lrange [lsort -integer -decreasing $rucksacks] 0 2] a b c

    return "Part 1: $a\nPart 2: [expr {$a + $b + $c}]"
}

proc main {argv} {
    if { [llength $argv] == 0 } {
        puts "Please provide one or more file names!"
        return 1
    }
    puts [join [lmap file $argv { processFile $file }] "\n\n"]
}

main $argv
