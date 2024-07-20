module top_module(
    input clk,
    input [7:0] d,
    output reg [7:0] q);
    reg [7:0] reg_q;
    
    initial begin
        reg_q = 8'b0;
        q = reg_q;
    end
    
    always @(posedge clk) begin
        reg_q <= d;
        q <= reg_q;
    end
endmodule
