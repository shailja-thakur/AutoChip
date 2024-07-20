module top_module (
	input [2:0] in,
	output [1:0] out
);

    // Use an integer to store the sum of the input bits
    wire [1:0] sum;
    
    assign sum = in[0] + in[1] + in[2];
    
    assign out = sum;

endmodule
