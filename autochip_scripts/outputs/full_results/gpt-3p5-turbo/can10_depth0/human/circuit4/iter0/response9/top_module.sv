module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

    // Define intermediate wires
    wire w1, w2, w3;

    // Assign intermediate wires
    assign w1 = a & b;
    assign w2 = ~c;
    assign w3 = d & w2;
    assign q = w1 | w3;

endmodule
