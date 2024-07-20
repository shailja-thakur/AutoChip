module top_module(
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out);
    
    reg [31:0] in_prev;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            in_prev <= 0;
            out <= 0;
        end else begin
            in_prev <= in;
            out <= out | ((in_prev & ~in) & ~reset);
        end
    end
    
endmodule
