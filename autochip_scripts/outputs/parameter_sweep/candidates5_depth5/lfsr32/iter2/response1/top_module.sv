module top_module(
	input clk,
	input reset,
	output reg [31:0] q);

	reg [31:0] feedback;

	always @(posedge clk) begin
		if (reset) begin
			q <= 32'h1;
		end
		else begin
			feedback <= q[30] ^ q[20] ^ q[0] ^ q[1];
			q <= {q[30:0], feedback};
		end
	end

endmodule
