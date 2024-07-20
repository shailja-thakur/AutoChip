module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] pedge
);

reg [7:0] in_dff;

always @(posedge clk) begin
    in_dff <= in;
    pedge <= (in & ~in_dff);
end

endmodule
