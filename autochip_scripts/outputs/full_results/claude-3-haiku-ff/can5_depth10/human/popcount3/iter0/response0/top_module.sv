module top_module (
    input [2:0] in,
    output [1:0] out
);

wire [1:0] p1, p2;

assign p1 = (in[0] == 1'b1) ? 2'b01 : 2'b00;
assign p2 = (in[1] == 1'b1) ? 2'b01 : 2'b00;
assign out = p1 + p2 + (in[2] == 1'b1 ? 2'b01 : 2'b00);

endmodule
