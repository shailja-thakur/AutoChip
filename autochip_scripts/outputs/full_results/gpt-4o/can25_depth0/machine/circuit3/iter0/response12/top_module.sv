module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

    wire or1, or2;

    // OR gate for inputs a and b
    assign or1 = a | b;

    // OR gate for inputs c and d
    assign or2 = c | d;

    // AND gate for the outputs of the OR gates
    assign q = or1 & or2;

endmodule
