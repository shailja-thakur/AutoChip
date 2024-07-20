module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] pedge
);

reg [7:0] in_dly;

always @(posedge clk) begin
    in_dly <= in;
    pedge <= in & ~in_dly;
end

endmodule
