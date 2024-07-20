module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

// Internal signals
wire q_internal;

// Logic gate
assign q_internal = b | c;
assign q = q_internal;

endmodule
