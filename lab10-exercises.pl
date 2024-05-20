% Part 1: Queries on list
% Ex1.1: search(Elem, List)
search(X, cons(X, _)).
search(X, cons(_, Xs)) :- search(X, Xs).

% Ex1.2: search2(Elem, List) looks for two consecutive occurrences of Elem in List
search2(X, cons(X, cons(X, _))).
search2(X, cons(_ , Xs)) :- search2(X, Xs).

% Ex1.3: search_two(Elem, List) looks for two occurrences of Elem with any element in between
search_two(X, cons(X, cons(_, cons(X, _)))).
search_two(X, cons(_, Xs)) :- search_two(X, Xs).

% Ex1.4: search_anytwo(Elem, List) looks for any Elem that occurs two times, anywhere
search_anytwo(X, cons(X, Xs)) :- search(X, Xs).
search_anytwo(X, cons(_, Xs)) :- search_anytwo(X, Xs).

% Part 2: Extracting information from a list
% Ex2.1: Peano size of a list
% size(List, Size) where Size will contain the number of elements in List
size(nil, zero).
size(cons(_, Xs), s(N)) :- size(Xs, N).

% Ex2.2: sum_list(List, sum)
sum(N, zero, N).
sum(N, s(M), s(R)) :- sum(N, M, R).

sum_list(nil, zero).
sum_list(cons(X, Xs), R) :- sum_list(Xs, K), sum(X, K, R).

% Ex2.3: count (in tail-recursive fashion)
% count(List, Element, NOccurrences)
% it uses count(List, Element, NOccurrencesSoFar, NOccurrences)
count(List, E, N) :- count(List, E, zero, N).
count(nil, E, N, N).
count(cons(E, L), E, N, M) :- count(L, E, s(N), M).
count(cons(E, L), E2, N, M) :- E \= E2, count(L, E2, N, M).

% Ex2.4: max(List, Max) where Max is the biggest element in List
% Suppose the list has at least one element
% it uses max(List, TempMax, Max)
greater(s(_), zero).
greater(s(N), s(M)) :- greater(N, M).

max(cons(E, L), Max) :- max(L, E, Max).
max(nil, E, E).
max(cons(E, L), E, Max) :- max(L, E, Max).
max(cons(E, L), E2, Max) :- greater(E2, E), max(L, E2, Max).
max(cons(E, L), E2, Max) :- greater(E, E2), max(L, E, Max).

maximum(cons(E, nil), E).
maximum(cons(E, L), Max) :- search(Max, L), greater(Max, E).

% Ex2.5: min-max(List, Min, Max) where Min is the smallest element in List, Max is the biggest element in List
% Suppose the list has at least one element
min(cons(E, L), Min) :- min(L, E, Min).
min(nil, E, E).
min(cons(E, L), E, Min) :- min(L, E, Min).
min(cons(E, L), E2, Min) :- greater(E2, E), min(L, E, Min).
min(cons(E, L), E2, Min) :- greater(E, E2), min(L, E2, Min).

minimum(cons(E, nil), E).
minimum(cons(E, L), Min) :- search(Min, L), greater(E, Min).

min-max(List, Min, Max) :- max(List, Max), min(List, Min).
minimum-maximum(List, Min, Max) :- maximum(List, Max), minimum(List, Min).

% Part 3: Compare lists
% Ex3.1: same(List1, List2)
same(nil, nil).
same(cons(E1, L1), cons(E2, L2)) :- E1=E2, same(L1, L2).

% Ex3.2: all_bigger(List1, List2)
% all elements in List1 are bigger than those in List2, 1 by 1
all_bigger(cons(E1, nil), cons(E2, nil)) :- greater(E1, E2).
all_bigger(cons(E1, L1), cons(E2, L2)) :- greater(E1, E2), all_bigger(L1, L2).

% Ex3.3: sublist(List1, List2) using search
% List1 should contain elements all also in List2
sublist(cons(E1, nil), cons(E2, L2)) :- search(E1, cons(E2, L2)).
sublist(cons(E1, L1), cons(E2, L2)) :- search(E1, cons(E2, L2)), sublist(L1, cons(E2, L2)).

% Part 4: Creating lists
% Ex4.1: seq(N, E, List) --> List is [E, E, ..., E] with size N
seq(zero, _, nil).
seq(s(N), E, cons(E, T)) :- seq(N, E, T).

% Ex4.2: seqR(N, List)
seqR(zero, nil).
seqR(s(N), cons(E, L)) :- E=N, seqR(N, L).

% Ex4.3: seqR2(N, List) --> List is [0, 1, ..., N-1]
% add a predicate last(List, E, NewList)
last(nil, X, cons(X, nil)).
last(cons(E, L1), X, cons(E, L2)) :- last(L1, X, L2).

seqR2(zero, nil).
seqR2(s(N), List) :- seqR2(N, L1), last(L1, N, List).

% Part 5: Port list functions
% last(List, X) where X is the last element in List
last(List2, X) :- last(List1, X, List2).
% ?- last(cons(a, cons(b, nil)), b). yes.
% ?- last(cons(a, cons(b, nil)), c). no.

% map(List, MappedList) where MappedList is obtained by adding 1 to each element in List
add_one(zero, s(zero)).
add_one(s(X), s(Y)) :- add_one(X, Y).

map(nil, nil).
map(cons(E1, L1), cons(E2, L2)) :- add_one(E1, E2), map(L1, L2).
% ?- map(cons(zero, cons(s(s(zero)), nil)), cons(s(zero), cons(s(s(s(zero))), nil))). yes.
% ?- map(cons(zero, nil), cons(s(s(zero)), nil)). no.

% filter(List, FilteredList) where FilteredList contains only the elements from List that are greater than zero
filter(nil, nil).
filter(cons(E1, L1), cons(E1, L2)) :- greater(E1, zero), filter(L1, L2).
filter(cons(E1, L1), L2) :- \+ greater(E1, zero), filter(L1, L2).
% ?- filter(cons(zero, cons(zero, cons(s(zero), cons(s(s(zero)), nil)))), cons(s(zero), cons(s(s(zero)), nil))). yes.
% ?- filter(cons(s(zero), nil), nil). no.

% count(List, NOccurrences) where NOccurrences is the number of occurrences in List that are greater than zero
count(nil, zero).
count(cons(E, L), s(N)) :- greater(E, zero), count(L, N).
count(cons(E, L), N) :- \+ greater(E, zero), count(L, N).
% ?- count(cons(zero, cons(s(zero), cons(zero, cons(s(s(s(s(zero)))), cons(zero, nil))))), s(s(zero))). yes.
% ?- count(cons(s(zero), nil), zero). no.

% find(List, Elem) where Elem is the first element in List that is greater than zero
find(nil, nil).
find(cons(E1, _), E1) :- greater(E1, zero).
find(cons(E1, L1), E) :- \+ greater(E1, zero), find(L1, E).
% ?- find(cons(zero, cons(zero, cons(s(zero), cons(s(s(zero)), nil)))), s(zero)). yes.
% ?- find(cons(zero, cons(s(s(zero)), cons(s(zero), nil))), s(zero)). no.

% drop(List, N, ResultingList) removes the first N elements from List, returning ResultingList
drop(List, zero, List).
drop(cons(_, L1), s(N), Res) :- drop(L1, N, Res).
% ?- drop(cons(s(zero), cons(zero, nil)), s(s(zero)), nil). yes.

% dropWhile(List, ResultingList) removes positive elements at the beginning of List, returning ResultingList
dropWhile(nil, nil).
dropWhile(cons(E1, L1), Res) :- greater(E1, zero), dropWhile(L1, Res).
dropWhile(cons(E1, L1), cons(E1, L1)) :- \+ greater(E1, zero).
% ?- dropWhile(cons(zero, cons(s(s(zero)), cons(s(zero), nil))), cons(zero, cons(s(s(zero)), cons(s(zero), nil)))). yes.
% ?- dropWhile(cons(s(s(zero)), cons(s(zero), cons(zero, cons(s(zero), nil)))), cons(zero, cons(s(zero), nil))). yes.
% ?- dropWhile(cons(s(zero), cons(zero, nil)), cons(s(zero), nil)). no.

% partition(List, Part1, Part2) where Part1 contains the elements from List that are greater than zero, Part2 contains all the others
partition(nil, nil, nil).
partition(cons(E, L), cons(E, L1), L2) :- greater(E, zero), partition(L, L1, L2).
partition(cons(E, L), L1, cons(E, L2)) :- \+ greater(E, zero), partition(L, L1, L2).
% ?- partition(cons(zero, cons(s(zero), cons(zero, nil))), cons(s(zero), nil), cons(zero, cons(zero, nil))). yes.
% ?- partition(cons(zero, cons(s(zero), cons(zero, nil))), cons(zero, cons(zero, nil)), cons(s(zero), nil)). no.

% reversed(List, ReversedList) where ReversedList contains the elements of List in reversed order
reversed(nil, nil).
reversed(cons(E1, L1), R) :- reversed(L1, Acc), last(Acc, E1, R).
% ?- reversed(cons(s(zero), cons(zero, nil)), cons(zero, cons(s(zero), nil))). yes.

% take(List, N, TakenList) where TakenList contains the first N elements of List
take(List, zero, nil).
take(cons(E1, L1), s(N), cons(E1, L2)) :- take(L1, N, L2).
% ?- take(cons(s(s(zero)), cons(s(zero), cons(zero, nil))), s(s(zero)), cons(s(s(zero)), cons(s(zero), nil))). yes.
% ?- take(cons(zero, cons(s(zero), cons(zero, nil))), zero, nil). yes.

% zip(List1, List2, ZippedList) combines List1 and List2 into ZippedList, a list of corresponding pairs
zip(nil, nil, nil).
zip(cons(E1, L1), cons(E2, L2), cons((E1, E2), T)) :- zip(L1, L2, T).
% ?- zip(cons(zero, nil), cons(s(zero), nil), cons((zero, s(zero)), nil)). yes.
