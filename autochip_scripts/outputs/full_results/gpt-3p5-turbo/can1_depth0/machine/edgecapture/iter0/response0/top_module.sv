module top_module(
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out);
    
    reg [31:0] d_last;
    
    initial begin
        d_last = 0;
        out = 0;
    end
    
    always @(posedge clk) begin
        if (reset) begin
            d_last <= 0;
            out <= 0;
        end else begin
            d_last <= in;
            out <= out | (~in & d_last);
        end
    end
endmodule
