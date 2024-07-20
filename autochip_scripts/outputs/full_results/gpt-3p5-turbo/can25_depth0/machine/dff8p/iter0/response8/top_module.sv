module top_module(
    input clk,
    input [7:0] d,
    input reset,
    output reg [7:0] q);
    
    reg [7:0] reg_q;
    
    always @(negedge clk) begin
        if (reset) begin
            reg_q <= 8'h34;
        end else begin
            reg_q <= d;
        end
    end
    
    assign q = reg_q;
    
endmodule
