module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output reg [3:0] out
);

always @(*) begin
    // Calculate starting index of the 4-bit block
    integer index;
    index = sel * 4;
    
    // Assign the 4-bit block to the output
    out = in[index +: 4];
end

endmodule
