module top_module(
	input clk,
	input d,
	output reg q);
    
    reg d_ff;
    
    always @(posedge clk)
    begin
        d_ff <= d;
    end
    
    always @(posedge clk)
    begin
        q <= d_ff;
    end
endmodule
