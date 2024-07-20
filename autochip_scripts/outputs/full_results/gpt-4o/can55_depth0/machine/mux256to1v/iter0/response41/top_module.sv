module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out
);
    // Calculate the starting index based on the selection vector
    wire [9:0] start_idx = {sel, 2'b00}; // sel*4 = sel << 2

    // Extract the 4-bit block from the input vector starting from the calculated index
    assign out = in[start_idx +: 4];

endmodule
