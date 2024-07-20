module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] pedge);

    reg [7:0] in_delayed;

    always @(posedge clk) begin
        // Positive edge detection for each bit
        pedge <= (in & ~in_delayed);
        // Update the delayed input
        in_delayed <= in;
    end
endmodule
