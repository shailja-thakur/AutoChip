module top_module (
	input [3:0] in,
	output [2:0] out_both,
	output [3:0] out_any,
	output [3:0] out_different
);

    // Assign the result of the bitwise AND operation
    assign out_both = in[2:0] & in[3:1];
    
    // Assign the result of the bitwise OR operation
    assign out_any = {in[2:0] | in[3:1], in[0]};
    
    // Assign the result of the bitwise XOR operation
    assign out_different = in ^ {in[3:1], in[0]};
    
endmodule
