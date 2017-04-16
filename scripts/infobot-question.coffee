class Question

  doQuestion: (arg) ->
    query = arg
    reply = ''
    finalQMark = query.test(/\?+\s*$/)

    query = query.replace(/^\s+|\s+$/g, '')

    # if ( !defined $query or $query =~ /^\s*$/ ) {
    #   return '';
    # }

    questionWord = ''

    if !isAddressed
      if !finalQMark
        return ''
    else
      if !canTalk
        return ''

    # dangerous; common preambles should be stripped before here
    if ( $query =~ /^forget /i or $query =~ /^no, / ) {
      return if ( exists $bots{$nuh} )
    }

    if ( $query =~ s/^literal\s+//i ) {
      &status("literal ask of '$query'.")
      $literal = 1
    }

    # convert to canonical reference form
    my $x;
    my @query;

    # 1: push original.
    push( @query, $query );

    # valid factoid.
    if ( $query =~ s/[!.]$// ) {
      push( @query, $query );
    }

    $x = &normquery($query);
    push( @query, $x ) if ( $x ne $query );
    $query = $x;

    $x = &switchPerson($query);
    push( @query, $x ) if ( $x ne $query );
    $query = $x;

    # where is x at?
    $query =~ s/\s+at\s*(\?*)$/$1/
    # explain x
    $query =~ s/^explain\s*(\?*)/$1/i
    # side whitespaces.
    $query = " $query "

    my $qregex = join '|', keys %{ $lang{'qWord'} };

    # purge prefix question string.
    if ( $query =~ s/^ ($qregex)//i ) {
      $questionWord = lc($1);
    }

    if ( $questionWord eq '' and $finalQMark and $addressed ) {
      $questionWord = 'where';
    }

    # bleh. hacked.
    $query =~ s/^\s+|\s+$//g;
    push( @query, $query ) if ( $query ne $x );

    if ( &IsChanConf('factoidArguments') > 0 ) {
      $result = &factoidArgs( $query[0] );

      return $result if ( defined $result );
    }
