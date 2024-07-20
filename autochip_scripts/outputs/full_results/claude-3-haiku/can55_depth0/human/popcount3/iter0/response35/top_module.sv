module top_module (
    input [2:0] in,
    output [1:0] out
);

wire [1:0] cnt1, cnt2;

assign cnt1 = (in[0] ? 2'b01 : 2'b00) + (in[1] ? 2'b01 : 2'b00);
assign cnt2 = (in[2] ? 2'b01 : 2'b00) + cnt1;

assign out = cnt2;

endmodule
