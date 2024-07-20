module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

	// Define the wire
	wire w1, w2, w3, w4;

	// Define the gates and their connections
	and gate1(w1, a, b);
	or gate2(w2, c, d);
	not gate3(w3, w1);
	nor gate4(q, w2, w3);

endmodule
