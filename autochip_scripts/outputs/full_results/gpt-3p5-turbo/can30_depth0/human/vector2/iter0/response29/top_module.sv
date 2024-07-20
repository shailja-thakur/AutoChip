module top_module (
    input [31:0] in,
    output [31:0] out
);

    // Initialize intermediate wires
    wire [7:0] byte0, byte1, byte2, byte3;

    // Assign bytes of the input vector to wires
    assign byte0 = in[7:0];
    assign byte1 = in[15:8];
    assign byte2 = in[23:16];
    assign byte3 = in[31:24];

    // Assign the reversed byte order to the output
    assign out = {byte3, byte2, byte1, byte0};

endmodule
