module top_module(
	input clk,
	input slowena,
	input reset,
	output reg [3:0] q);
	
	// Internal wire to control counter increment
	reg increment;
	
	// Synchronous reset
	always @(posedge clk or posedge reset) begin
		if(reset) begin
			q <= 0;
			increment <= 0;
		end
		else if(slowena) begin
			increment <= 1;
		end
	end
	
	// Decade counter
	always @(posedge clk) begin
		if(increment) begin
			if(q == 9) begin
				q <= 0;
			end
			else begin
				q <= q + 1;
			end
		end
	end
	
endmodule
