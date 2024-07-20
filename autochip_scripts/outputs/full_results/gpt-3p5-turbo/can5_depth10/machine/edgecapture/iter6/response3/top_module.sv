module top_module(
	input wire clk,
	input wire reset,
	input wire [31:0] in,
	output wire [31:0] out);

	reg [31:0] d_last = 0;

	always @(posedge clk) begin
		if (reset) begin
			out <= 0;
			d_last <= 0;
		end else begin
			d_last <= in;
			out <= out | (~in & d_last);
		end
	end

	// Initialize out to 0 when reset is asserted
	initial begin
		out <= 0;
	end

endmodule
