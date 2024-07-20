module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

// Instantiate the gates for the circuit
and gate1 (a, b, q1);
and gate2 (c, d, q2);
or gate3 (q1, q2, q);

endmodule
