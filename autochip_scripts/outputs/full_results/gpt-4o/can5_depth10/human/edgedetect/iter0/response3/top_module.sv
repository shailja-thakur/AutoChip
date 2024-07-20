module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] pedge);

    reg [7:0] in_d;

    always @(posedge clk) begin
        in_d <= in;                 // Register the input signals
        pedge <= (~in_d) & in;      // Detect positive edge: previous cycle was 0, current cycle is 1
    end
endmodule
