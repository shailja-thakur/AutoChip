module top_module(
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out);
    
    reg [31:0] in_d1;
    
    always @(posedge clk) begin
        if (reset) begin
            out <= 0;
        end else begin
            in_d1 <= in;
            out <= out | (in_d1 & ~in);
        end
    end
    
endmodule
