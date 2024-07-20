module top_module (
	input a,
	input b,
	output sum,
	output cout
);

    // Logic for sum
    assign sum = a ^ b;
    
    // Logic for carry-out
    assign cout = a & b;

endmodule
