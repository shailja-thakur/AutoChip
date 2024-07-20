module top_module(
	input clk,
	input load,
	input [511:0] data,
	output reg [511:0] q
);

	reg [511:0] next_q;

	always @(posedge clk) begin
		if (load) begin
			q <= data;
		end
		else begin
			// Compute the next state of each cell using the Rule 90 logic
			for (int i = 0; i < 512; i++) begin
				next_q[i] = q[(i-1)%512] ^ q[(i+1)%512];
			end
			q <= next_q;
		end
	end

endmodule
