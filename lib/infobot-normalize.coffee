class Normalize

  constructor: (@str, @isAddressed) ->

  query: (str) ->
    q = str

    # where blah is -> where is blah
    q = q.replace(/\s(where|what|who)\s+(\S+)\s+(is|are)\s/i, $1 $3 $2 )
    # where blah is -> where is blah
    q = q.replace(/\s(where|what|who)\s+(.*)\s+(is|are)\s/i, $1 $3 $2 )

    q = q.replace(/^\s*(.*?)\s*/, $1)

    q = q.replace(/be tellin\'?g?/i, 'tell')
    q = q.replace(/\s\'?bout/i, ' about')

    q = q.replace(/,? any(hoo?w?|ways?)/ig, '')
    q = q.replace(/,?\s*(pretty )*please\??\s*$/i, '?')

    # what country is ...
    # if ( $in =~
    #   s/wh(at|ich)\s+(add?res?s|country|place|net (suffix|domain))/wh$1 /ig
    #   )
    # {
    #     if ( ( length($in) == 2 ) && ( $in !~ /^\./ ) ) {
    #         $in = '.' . $in;
    #     }
    #     $in .= '?';
    # }

    # profanity filters.  just delete it
    q = q.replace(/th(e|at|is) (((m(o|u)th(a|er) ?)?fuck(in\'?g?)?|hell|heck|(god-?)?damn?(ed)?) ?)+/ig, '')
    q = q.replace(/wtf/gi, 'where')
    q = q.replace(/this (.*) thingy?/gi, ' ' + $1)
    q = q.replace(/this thingy? (called )?/gi, '')
    q = q.replace(/ha(s|ve) (an?y?|some|ne) (idea|clue|guess|seen) /ig, 'know ')
    q = q.replace(/does (any|ne|some) ?(1|one|body) know /ig, '')
    q = q.replace(/do you know /ig, '')
    q = q.replace(/can (you|u|((any|ne|some) ?(1|one|body)))( please)? tell (me|us|him|her)/ig, '')
    q = q.replace(/where (\S+) can \S+ (a|an|the)?/ig, '')
    # where can i find
    q = q.replace(/(can|do) (i|you|one|we|he|she) (find|get)( this)?/i, 'is')
    # where i can find
    q = q.replace(/(i|one|we|he|she) can (find|get)/gi, 'is')
    # this should be more specific
    q = q.replace(/(the )?(address|url) (for|to) /i, '')
    q = q.replace(/(where is )+/ig, 'where is ')
    q = q.replace(/\s+/g, ' ')
    q = q.replace(/^\s+/, '')

    # if ( $in =~ s/\s*[\/?!]*\?+\s*$// ) {
    #     $finalQMark = 1;
    # }

    q = q.replace(/\s+/g, ' ')
    q = q.replace(/^\s*(.*?)\s*$/, $1)
    # why twice, see Question.pl
    q = q.replace(/^\s+|\s+$/g, '')

    q

  subject: (str, addressed) ->
    sub = str

    # fix genitives
    sub = sub.replace(/(^|\W)\Q$who\Es\s+/ig, $1 + $who + '\'s ')
    sub = sub.replace(/(^|\W)\Q$who\Es$/ig, $1 + $who + '\'s')
    sub = sub.replace(/(^|\W)\Q$who\E\'(\s|$)/ig, $1 + $who + '\'s' + $2)

    sub = sub.replace(/(^|\s)i\'m(\W|$)/ig, $1 + $who + ' is' + $2)
    sub = sub.replace(/(^|\s)i\'ve(\W|$)/ig, $1 + $who + ' has' + $2)
    sub = sub.replace(/(^|\s)i have(\W|$)/ig, $1 + $who + ' has' + $2)
    sub = sub.replace(/(^|\s)i haven\'?t(\W|$)/ig, $1 + $who + ' has not' + $2)
    sub = sub.replace(/(^|\s)i(\W|$)/ig, $1 + $who + $2)
    sub = sub.replace(/\sam\b/i, ' is')
    sub = sub.replace(/\bam /i, 'is')
    sub = sub.replace(/(^|\s)(me|myself)(\W|$)/ig, $1 + $who + $3)
    # turn 'my' into name's
    sub = sub.replace(/(^|\s)my(\W|$)/ig, $1 + $who + '\'s' + $2)
    sub = sub.replace(/(^|\W)you\'?re(\W|$)/ig, $1 + 'you are' + $2)

    # if addressed
    #   my $mynick = 'UNDEF';
    #   $mynick = $conn->nick() if ($conn);
    #
    #   # is it safe to remove $in from here, too?
    #   $in =~ s/yourself/$mynick/i;
    #   $in =~ s/(^|\W)are you(\W|$)/$1is $mynick$2/ig;
    #   $in =~ s/(^|\W)you are(\W|$)/$1$mynick is$2/ig;
    #   $in =~ s/(^|\W)you(\W|$)/$1$mynick$2/ig;
    #   $in =~ s/(^|\W)your(\W|$)/$1$mynick\'s$2/ig;

    sub

module.exports = Normalize
