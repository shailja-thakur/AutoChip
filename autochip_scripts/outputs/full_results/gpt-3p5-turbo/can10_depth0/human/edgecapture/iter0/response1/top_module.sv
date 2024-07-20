module top_module(
	input clk,
	input reset,
	input [31:0] in,
	output reg [31:0] out);
	    reg [31:0] in_prev;
	    integer i;
	    
	    always @(posedge clk or posedge reset) begin
	        if (reset)
	            in_prev <= 0;
	        else
	            in_prev <= in;
	    end
	    
	    always @(posedge clk) begin
	        for (i = 0; i < 32; i = i + 1) begin
	            if (in_prev[i] && !in[i])
	                out[i] <= 1;
	            else
	                out[i] <= 0;
	        end
	    end
endmodule
