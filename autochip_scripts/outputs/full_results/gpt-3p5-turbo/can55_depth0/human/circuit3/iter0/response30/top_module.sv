module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

// create internal wire q_wire to connect to output q
wire q_wire;

// implement the combinational logic
assign q_wire = ~((~b | c) & (a | ~d));

// connect q_wire to output q
assign q = q_wire;

endmodule
