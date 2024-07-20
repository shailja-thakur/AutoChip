module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] pedge);

    reg [7:0] in_prev;

    always @(posedge clk) begin
        in_prev <= in;
        pedge <= (in & ~in_prev);
    end

endmodule
