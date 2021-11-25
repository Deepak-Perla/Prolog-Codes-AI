action(state(A, B, left), state(C, D, right), move(E, F, right)) :-
	E is A - C,
	F is B - D.
action(state(A, B, right), state(C, D, left), move(E, F, left)) :-
	E is C - A,
	F is D - B.

boat(2, 0).
boat(1, 0).
boat(1, 1).
boat(0, 1).
boat(0, 2).

safeState(A, A).
safeState(3, _).
safeState(0, _).

newState(state(A, B, left), state(C, D, right)) :-
	boat(E, F),
	E =< A,
	F =< B,
	C is A - E,
	D is B - F,
	safeState(C, D).
newState(state(A, B, right), state(C, D, left)) :-
	boat(E, F),
	C is A + E,
	D is B + F,
	C =< 3,
	D =< 3,
	safeState(C, D).

missionaryCanSolve(state(0, 0, right), _, []).
missionaryCanSolve(A, B, [C|D]) :-
	newState(A, E),
	\+ member(E, B),
	action(A, E, C),
	missionaryCanSolve(E, [E|B], D).