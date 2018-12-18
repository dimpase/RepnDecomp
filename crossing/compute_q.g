# This is an implementation of an algorithm due to D.R. Woodall to
# compute the number of adjacent interchanges needed to change a cycle
# a into another cycle b.

LoadPackage("RepnDecomp");

# Converts a permutation to a list. i.e. if you have (a,b,c), the list
# is [a,b,c]. I assume we only get perms of the form (1.....), that is
# cycles with a 1 in them.
MyListPerm := function(perm)
    local result, current;
    result := [];
    current := 1;

    repeat
        Add(result, current);
        current := current^perm;
    until current = 1; # when we reach 1, we have written down the
                       # whole cycle

    return result;
end;

# Cyclically moves elements in a list left by n elements
ShiftLeft := function(list, n)
    local shift;
    shift := n mod (Length(list));
    return Concatenation(Drop@RepnDecomp(list, shift),
                         Take@RepnDecomp(list, shift));
end;

NumberInterchangesBetween := function(a, b)
    local al, bl, n, f, dist;

    # Convert them to lists
    al := MyListPerm(a);
    bl := MyListPerm(b);

    n := Length(al);

    # We rename elements so that al "is" [0..n-1]. This is so we match
    # up with Woodall's description and avoid off-by-one errors.
    bl := List(bl, elem -> Position(al, elem)-1);
    al := [0..(n-1)];


    # This is a useful function defined by Woodall
    f := function(r)
        if r = 0 then
            return 0;
        elif 0 < r and r < n/2 then
            return 2*r - 1;
        elif r = n/2 then
            return 2*r - 2;
        fi;
        Error("Bad value for r: ", r);
    end;

    # We imagine the entries of a spaced evenly around a circle. There
    # are n different ways to superimpose b on top of a, dist_i
    # calculates the distance assuming one of the n
    # superimpositions. We consider the ith choice to be b, but
    # shifted left i times.
    dist := function(i)
        local i_bl, alpha, beta, gamma;

        # This is the shifted version of b
        i_bl := ShiftLeft(bl, i);

        # alpha(i, j) denotes the number in a coinciding with j in b
        # when b is in position i. This is equal to al[Position(i_bl,
        # j)], but we already know the elements of al.
        alpha := j -> Position(i_bl, j)-1;

        # Now j - alpha(i, j) is equal (mod n) to the distance that j
        # has to move in the positive direction from its position in b
        # to its final position

        # beta(i, j) denotes the absolute value of the integer of
        # minimum absolute value that is congruent (mod n) to j -
        # alpha(i, j), so beta(i ,j) is the shortest distance that j
        # must move.
        beta := function(j)
            local x;
            x := (j - alpha(j)) mod n;
            return Minimum([x, n - x]);
        end;

        gamma := j -> (1/2)*f(beta(j));

        return Sum([0..(n-1)], j -> gamma(j));
    end;

    # The final result is the smallest distance between a and b over
    # all choices of rotation of b.
    return Minimum(List([1..n], i -> dist(i)));
end;
