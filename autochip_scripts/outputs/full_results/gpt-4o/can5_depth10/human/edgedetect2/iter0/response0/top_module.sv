module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] anyedge);

    reg [7:0] in_prev;

    // Detect any edge and store result in anyedge
    always @(posedge clk) begin
        anyedge <= (in & ~in_prev) | (~in & in_prev);
        in_prev <= in;
    end
    
endmodule
