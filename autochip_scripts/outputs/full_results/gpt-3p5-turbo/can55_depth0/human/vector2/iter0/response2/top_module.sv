module top_module (
    input [31:0] in,
    output [31:0] out
);
    wire [31:0] reversed_byte;

    assign reversed_byte[31:24] = in[7:0];
    assign reversed_byte[23:16] = in[15:8];
    assign reversed_byte[15:8] = in[23:16];
    assign reversed_byte[7:0] = in[31:24];

    assign out = reversed_byte;

endmodule
