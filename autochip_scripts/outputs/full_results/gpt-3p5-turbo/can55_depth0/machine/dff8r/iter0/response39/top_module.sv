module top_module(
	input wire clk,
	input wire [7:0] d,
	input wire reset,
	output reg [7:0] q);
	
	always @(posedge clk) begin
		if (reset) begin
			q <= 8'b0; // Set output q to 0 when reset is high
		end else begin
			q <= d; // Set output q to value of input d
		end
	end
	
endmodule
