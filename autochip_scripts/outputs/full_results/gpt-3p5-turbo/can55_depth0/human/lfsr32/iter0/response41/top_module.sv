module top_module(
	input clk,
	input reset,
	output reg [31:0] q);

	// Internal signals
	reg [31:0] d;

	// Reset logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			q <= 32'h1;
			d <= 32'b0;
		end else begin
			q <= d;
			d <= {d[30:0], d[22] ^ d[2] ^ d[1]};
		end
	end

endmodule
