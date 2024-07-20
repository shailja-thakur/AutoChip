module top_module (
    input [31:0] in,
    output [31:0] out
);

    reg [31:0] temp;

    // Reverse byte order
    assign temp[31:24] = in[7:0];
    assign temp[23:16] = in[15:8];
    assign temp[15:8] = in[23:16];
    assign temp[7:0] = in[31:24];

    // Output the reversed byte order
    assign out = temp;

endmodule
