module top_module(
    output reg out,
    input clk);

    always @(posedge clk) begin
        out <= 0;
    end
    
endmodule
