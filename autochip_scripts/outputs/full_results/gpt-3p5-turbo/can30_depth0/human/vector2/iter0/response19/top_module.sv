module top_module (
    input [31:0] in,
    output [31:0] out
);

    reg [7:0] byte_0;
    reg [7:0] byte_1;
    reg [7:0] byte_2;
    reg [7:0] byte_3;

    assign byte_0 = in[7:0];
    assign byte_1 = in[15:8];
    assign byte_2 = in[23:16];
    assign byte_3 = in[31:24];

    assign out = {byte_3, byte_2, byte_1, byte_0};

endmodule
