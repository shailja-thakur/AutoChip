module top_module (
	input [2:0] in,
	output [1:0] out
);
    // Declare wire for intermediate calculation
    wire [2:0] sum;
    
    // Perform addition of input bits
    assign sum = in[2] + in[1] + in[0];
    
    // Assign output bits
    assign out[1] = sum[2];
    assign out[0] = sum[1];
    
endmodule
