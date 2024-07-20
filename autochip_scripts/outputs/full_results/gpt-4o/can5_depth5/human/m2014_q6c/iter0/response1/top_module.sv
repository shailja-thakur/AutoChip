module top_module (
	input [6:1] y,
	input w,
	output Y2,
	output Y4
);

    // Next state for Y2 (State B):
    // Y2 = (y[1] & ~w)   // From State A to State B on w = 0
    
    assign Y2 = y[1] & ~w;

    // Next state for Y4 (State D):
    // Y4 = (y[2] & w) |  // From State B to State D on w = 1
    //       (y[3] & w) |  // From State C to State D on w = 1
    //       (y[6] & w) |  // From State F to State D on w = 1
    //       (y[5] & w);   // From State E to State D on w = 1

    assign Y4 = (y[2] & w) | (y[3] & w) | (y[6] & w) | (y[5] & w);

endmodule
