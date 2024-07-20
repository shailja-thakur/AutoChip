module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out
);

wire [31:0] offset;

// Calculate the starting index of the 4-bit block in the input vector
assign offset = sel * 4;

// Extract the 4-bit block from the input vector based on the calculated index
assign out = in[offset+3:offset];

endmodule
