module top_module( 
    input [7:0] in,
    output [7:0] out
);

	// Insert your code here

	assign out[7:0] = {7'b0, in[6:1], in[0:5]};

endmodule