module top_module(
    input clk,
    input [7:0] d,
    output reg [7:0] q);
        
    reg [7:0] reg_data;
        
    initial begin
        reg_data = 8'h0;
    end
        
    always @(posedge clk) begin
        reg_data <= d;
    end
        
    assign q = reg_data;
        
endmodule
