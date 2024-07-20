module top_module(
    input clk,
    input [7:0] d,
    output reg [7:0] q);
    
    reg [7:0] reg_q;
    
    always @(posedge clk) begin
        reg_q <= d;
    end
    
    initial begin
        reg_q = 8'h0;
    end
    
    assign q = reg_q;
    
endmodule
