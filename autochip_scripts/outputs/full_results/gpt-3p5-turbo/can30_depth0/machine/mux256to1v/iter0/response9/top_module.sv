module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);
    // Declare internal wire
    wire [3:0] start_index;
    
    // Calculate the starting index of the 4-bit block in the input vector
    assign start_index = sel << 2;
    
    // Extract the 4-bit block from the input vector
    assign out = in[start_index + 3 : start_index];
endmodule
