// The following is the state transition table for a Moore state machine with one input, one output, and four states. Implement this state machine. Include an asynchronous reset that resets the FSM to state A.

//	 	 	  Next state

//	State					Output
//			in=0	in=1
//	A		A		B		0
//	B		C		B		0
//	C		A		D		0
//	D		C		B		1


module top_module(
    input clk,
    input in,
    input areset,
    output out); //

    // Insert your code below
    
    // State transition logic

    // State flip-flops with asynchronous reset

    // Output logic

endmodule
