module top_module(
    input clk,
    input [7:0] d,
    output reg [7:0] q);
    
    reg [7:0] q_tmp;
    
    always @(posedge clk) begin
        q_tmp <= d;
    end
    
    assign q = q_tmp;
    
endmodule
