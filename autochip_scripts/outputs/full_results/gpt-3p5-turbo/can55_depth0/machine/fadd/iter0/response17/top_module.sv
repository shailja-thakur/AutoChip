module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

    // Internal wires
    wire temp_cout;
    wire temp_sum;
    
    // Generate sum
    assign temp_sum = (a + b + cin) % 2;
    
    // Generate carry out
    assign temp_cout = (a + b + cin) >= 2 ? 1'b1 : 1'b0;
    
    // Output assignments
    assign sum = temp_sum;
    assign cout = temp_cout;
    
endmodule
