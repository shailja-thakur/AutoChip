module top_module(
    input wire clk,
    output reg out);

    always @(posedge clk) begin
        out <= 0;
    end
    
endmodule
