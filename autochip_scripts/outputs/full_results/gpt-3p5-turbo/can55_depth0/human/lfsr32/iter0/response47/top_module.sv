module top_module(
	input clk,
	input reset,
	output reg [31:0] q);

	reg [31:0] feedback;
	wire tap;

	// Feedback taps
	assign tap = q[31] ^ q[21] ^ q[1] ^ q[0];

	// Reset condition
	always @(posedge clk) begin
		if (reset) begin
			q <= 32'h1;
		end else begin
			// LFSR operation
			q <= {q[30:0], tap};
		end
	end
endmodule
