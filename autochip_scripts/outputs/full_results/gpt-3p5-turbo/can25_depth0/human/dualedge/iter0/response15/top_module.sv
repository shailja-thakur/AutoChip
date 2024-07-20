module top_module(
    input clk,
    input d,
    output reg q,
    reg previous_clk);

    always @(posedge clk) begin
        previous_clk <= clk;
        if (clk != previous_clk) begin
            q <= d;
        end
    end
    
endmodule
