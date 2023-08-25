// The following is the state transition table for a Moore state machine with one input, one output, and four states. Use the following state encoding: A=2'b00, B=2'b01, C=2'b10, D=2'b11.

// Implement only the state transition logic and output logic (the combinational logic portion) for this state machine. Given the current state (state), compute the next_state and output (out) based on the state transition table.

//	 	 	  Next state

//	State					Output
//			in=0	in=1
//	A		A		B		0
//	B		C		B		0
//	C		A		D		0
//	D		C		B		1

module top_module(
    input in,
    input [1:0] state,
    output [1:0] next_state,
    output out); //

    parameter A=0, B=1, C=2, D=3;

    // Insert your code below

    // State transition logic: next_state = f(state, in)

    // Output logic:  out = f(state) for a Moore state machine

endmodule


