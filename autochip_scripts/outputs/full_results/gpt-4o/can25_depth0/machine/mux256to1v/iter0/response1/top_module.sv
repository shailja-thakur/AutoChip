module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output reg [3:0] out
);

    always @(*) begin
        // Calculate the starting index of the 4-bit block
        integer start_index;
        start_index = sel * 4;
        
        // Extract the 4-bit block from input vector based on the starting index
        out = in[start_index +: 4];
    end

endmodule
