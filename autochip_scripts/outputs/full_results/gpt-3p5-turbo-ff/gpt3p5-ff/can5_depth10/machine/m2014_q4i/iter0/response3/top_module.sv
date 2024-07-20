module top_module(
	output reg out);
	
	always @(posedge clk or posedge rst) begin
		if (rst) begin
			out <= 0;
		end else begin
			out <= 0;
		end
	end
	
endmodule
