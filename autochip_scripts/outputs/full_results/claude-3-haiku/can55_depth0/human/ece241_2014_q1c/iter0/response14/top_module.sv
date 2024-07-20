module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);

wire [8:0] result;

assign result = a + b;
assign s = result[7:0];
assign overflow = result[8] ^ result[7];

endmodule
