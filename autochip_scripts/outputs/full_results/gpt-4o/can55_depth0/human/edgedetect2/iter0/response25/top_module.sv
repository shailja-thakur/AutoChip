module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] anyedge);

    reg [7:0] prev;

    always @(posedge clk) begin
        anyedge <= in & ~prev;
        prev <= in;
    end
endmodule
