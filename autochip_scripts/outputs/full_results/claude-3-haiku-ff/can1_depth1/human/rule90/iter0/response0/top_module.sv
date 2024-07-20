module top_module(
	input clk,
	input load,
	input [511:0] data,
	output reg [511:0] q
);

always @(posedge clk) begin
	if (load) begin
		q <= data;
	end
	else begin
		// Create a temporary array to store the next state
		reg [511:0] next_q;

		// Compute the next state of each cell
		for (int i = 0; i < 512; i++) begin
			next_q[i] = q[(i == 0) ? 0 : i-1] ^ q[i] ^ ((i == 511) ? 0 : q[i+1]);
		end

		// Update the current state
		q <= next_q;
	end
end

endmodule
