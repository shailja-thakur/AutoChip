module top_module(
    input clk,
    output reg out);

    always @(posedge clk) begin
        out <= 0;
    end
    
endmodule
