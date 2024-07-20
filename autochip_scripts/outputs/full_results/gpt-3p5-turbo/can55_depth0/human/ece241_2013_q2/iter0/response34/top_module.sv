module top_module (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);

// Define intermediate signals
wire w1, w2, w3;

// Calculate intermediate signals w1, w2, w3
assign w1 = (a & ~b & ~c & ~d) | (~a & b & ~c & ~d) | (~a & ~b & c & ~d) | (~a & ~b & ~c & d);
assign w2 = (a & ~b & c & d) | (~a & b & c & d) | (a & b & ~c & d) | (a & b & c & ~d);
assign w3 = a | b | c | d;

// Calculate out_sop using w1, w2, and w3
assign out_sop = ((~w3 & w1) | (w3 & ~w1 & ~w2));

// Calculate out_pos using w1, w2, and w3
assign out_pos = w3 ^ (w1 & w2);

endmodule
