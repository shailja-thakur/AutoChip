module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);
    wire [3:0] start_index;
    
    assign start_index = sel * 4;
    assign out = in[start_index +: 4];
    
endmodule
