module top_module (
	input [5:0] y,
	input w,
	output Y1,
	output Y3
);

    // Y1 corresponds to state B, and Y3 corresponds to state D.
    // Assign Y1 and Y3 based on the current state y and input w.
    
    assign Y1 = (y[0] && w) || (y[4] && w);   // A --1--> B, E --1--> B (but since E loops to itself in state machine, we only have A --1--> B)
    assign Y3 = (y[1] && !w) || (y[2] && !w) || (y[5] && !w);  // B --0--> D, C --0--> D, F --0--> D
    
endmodule
