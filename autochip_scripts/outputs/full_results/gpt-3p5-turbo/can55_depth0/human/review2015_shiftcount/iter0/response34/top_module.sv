module top_module(
	input clk,
	input shift_ena,
	input count_ena,
	input data,
	output reg [3:0] q);
	
	always @(posedge clk) begin
	    if(count_ena) begin
	        if(q != 4'b0000)
	            q <= q - 1;
	    end
	    else begin
	        if(shift_ena)
	            q <= {data, q[3:1]};
	    end
	end
	
endmodule
