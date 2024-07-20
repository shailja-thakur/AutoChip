module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out
);

// Calculate the starting bit index for the selected 4-bit input
wire [9:0] start_bit = sel * 4;

// Extract the selected 4-bit input from the 1024-bit input vector
assign out = in[start_bit+3:start_bit];

endmodule
