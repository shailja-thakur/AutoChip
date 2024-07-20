module top_module(
    input clk,
    input d,
    output reg q);
    
    reg d_ff1;
    reg d_ff2;
    
    always @(posedge clk) begin
        d_ff1 <= d;
    end
    
    always @(negedge clk) begin
        d_ff2 <= d_ff1;
        q <= d_ff2;
    end
    
endmodule
