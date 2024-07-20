module top_module(
	input a, 
	input b,
	input c,
	output out
);
	
	// Define the internal signals
	wire w1, w2, w3;

	// Implement the circuit
	and gate1(w1, b, c);
	and gate2(w2, a, b);
	or gate3(w3, w1, w2);
	assign out = w3;

endmodule
module and(
    input a,
    input b,
    output y
);
    assign y = a & b;
endmodule
module or(
    input a,
    input b,
    output y
);
    assign y = a | b;
endmodule
