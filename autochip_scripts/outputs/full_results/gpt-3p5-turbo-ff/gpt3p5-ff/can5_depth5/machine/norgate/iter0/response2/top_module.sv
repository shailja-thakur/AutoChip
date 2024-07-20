module top_module(
	input a, 
	input b,
	output out
);

// OR gate
wire or_out = a | b;

// inverter
assign out = ~or_out;

endmodule
