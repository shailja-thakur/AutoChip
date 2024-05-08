// The following is the state transition table for a Moore state machine with one input, one output, and four states. Use the following one-hot state encoding: A=4'b0001, B=4'b0010, C=4'b0100, D=4'b1000.

// Derive state transition and output logic equations by inspection assuming a one-hot encoding. Implement only the state transition logic and output logic (the combinational logic portion) for this state machine. (The testbench will test with non-one hot inputs to make sure you're not trying to do something more complicated).

//	 	 	  Next state

//	State					Output
//			in=0	in=1
//	A		A		B		0
//	B		C		B		0
//	C		A		D		0
//	D		C		B		1

// Hint: Logic equations for one-hot state transition logic can be derived by looking at in-edges of the state transition diagram.

module top_module(
    input in,
    input [3:0] state,
    output [3:0] next_state,
    output out); //

    parameter A=0, B=1, C=2, D=3;

    // Insert your code below

    // State transition logic: Derive an equation for each state flip-flop.
    assign next_state[A] = ...;
    assign next_state[B] = ...;
    assign next_state[C] = ...;
    assign next_state[D] = ...;

    // Output logic: 
    assign out = ...;

endmodule