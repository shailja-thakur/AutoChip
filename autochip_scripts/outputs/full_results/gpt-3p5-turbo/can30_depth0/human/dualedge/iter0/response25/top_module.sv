module top_module(
    input clk,
    input d,
    output reg q);
    
    reg previous_clk_state;
    
    always @(posedge clk) begin
        if (clk != previous_clk_state) begin
            q <= d;
        end
        previous_clk_state <= clk;
    end
    
endmodule
