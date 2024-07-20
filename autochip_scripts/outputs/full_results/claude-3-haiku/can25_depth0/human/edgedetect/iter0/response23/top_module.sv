module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] pedge
);

reg [7:0] in_ff1, in_ff2;

always @(posedge clk) begin
    in_ff1 <= in;
    in_ff2 <= in_ff1;
    pedge <= in_ff1 & ~in_ff2;
end

endmodule
