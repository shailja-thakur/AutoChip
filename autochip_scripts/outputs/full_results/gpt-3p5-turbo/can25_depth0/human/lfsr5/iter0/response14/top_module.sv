module top_module(
	input clk,
	input reset,
	output reg [4:0] q);
	
	reg [4:0] d;

	always @(posedge clk) begin
		if (reset)
			d <= 5'b11111;
		else begin
			d[4] <= d[3] ^ d[0];
			d[3:0] <= d[4:1];
		end
	end

	assign q = d;

endmodule
