module top_module (
	input a, 
	input b,
	input c,
	input d,
	output out
);

// Define intermediate signals
wire w1, w2, w3, w4, w5, w6;

// Implement the circuit logic using gates
assign w1 = (~a & ~b & ~c & d) | (a & ~b & ~c & d) | (~a & b & c & d) | (a & b & ~c & ~d);
assign w2 = (~a & ~b & ~c & d) | (~a & ~b & ~c & ~d) | (~a & b & ~c & d) | (~a & ~b & c & d);
assign w3 = (~a & ~b & ~c & d) | (~a & ~b & ~c & ~d) | (~a & b & c & ~d) | (a & ~b & ~c & ~d);
assign w4 = (~a & ~b & ~c & d) | (a & ~b & ~c & d) | (~a & ~b & ~c & d) | (~a & b & ~c & ~d);
assign w5 = (~a & ~b & c & d) | (~a & ~b & c & d) | (~a & b & c & d) | (a & ~b & ~c & d);
assign w6 = (a & b & c & d) | (~a & ~b & ~c & d) | (a & b & ~c & d) | (~a & b & c & d);

// Assign the output
assign out = w1 | w2 | w3 | w4 | w5 | w6;

endmodule
