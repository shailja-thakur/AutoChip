module top_module(
	output reg out);

	initial begin
		#5;
		$finish;
	end
	
	always @(#) begin
		out = 0;
	end
endmodule
