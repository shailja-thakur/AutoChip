module top_module(
    input [31:0] a,
    input [31:0] b,
    input sub,
    output [31:0] sum
);

    wire [15:0] a16, b16;
    wire [1:0] cout16;

    add16 #(.WIDTH(16)) add16_1 (a[15:0], b[15:0], 1'b0, a16, cout16);
    add16 #(.WIDTH(16)) add16_2 (a[15:0] ^ b[15:0], 1'b0, 1'b0, a16, cout16);

    wire [31:0] sum;

    assign sum[15:0] = a16;
    assign sum[31:16] = add16_2.sum;

endmodule