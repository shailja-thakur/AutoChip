module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out
);

    // Calculate the starting index of the 4-bit block in the input vector (in)
    wire [9:0] index = {2'b00, sel, 2'b00};

    // Extract the 4-bit block from the input vector (in) using the calculated index
    assign out = in[index +: 4];

endmodule
