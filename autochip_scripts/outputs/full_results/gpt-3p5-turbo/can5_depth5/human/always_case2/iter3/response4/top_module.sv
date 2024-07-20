module priority_encoder (
    input [3:0] in,
    output [1:0] pos
);

assign pos = (in != 0) ? {in[3:2] == 2'b01 ? 2'b00 : 2'b01} : 2'b00;

endmodule
module top_module (
    input [3:0] in,
    output reg [1:0] pos
);

priority_encoder priority_encoder1 (
    .in(in),
    .pos(pos)
);

endmodule
