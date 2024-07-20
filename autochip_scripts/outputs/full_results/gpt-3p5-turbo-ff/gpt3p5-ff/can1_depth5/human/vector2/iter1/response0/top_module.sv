module top_module (
    input [31:0] in,
    output [31:0] out
);

    // Create intermediate wire connections for byte reversal
    wire [7:0] byte0;
    wire [7:0] byte1;
    wire [7:0] byte2;
    wire [7:0] byte3;

    // Connecting input bits to byte wires
    assign byte0 = in[7:0];
    assign byte1 = in[15:8];
    assign byte2 = in[23:16];
    assign byte3 = in[31:24];

    // Reversing the byte order of 32-bit input
    assign out = {byte0, byte1, byte2, byte3};

endmodule
