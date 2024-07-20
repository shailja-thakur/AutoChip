module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] anyedge);

    reg [7:0] prev_in;

    always @(posedge clk) begin
        anyedge <= (in & ~prev_in); // Detect rising edges
        prev_in <= in;
    end
endmodule
