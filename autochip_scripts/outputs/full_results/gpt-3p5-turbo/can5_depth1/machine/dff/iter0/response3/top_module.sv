module top_module(
    input wire clk,
    input wire d,
    output reg q
);
    initial begin
        q = 1'b0;
    end
    
    always @(posedge clk) begin
        q <= d;
    end
endmodule
