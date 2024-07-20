module top_module(
	input clk,
	input reset,
	output reg [4:0] q
	);

	always @(posedge clk) begin
		if (reset) begin
			q <= 5'b00001; // Reset state to 1
		end else begin
			q[4] <= q[0]; // Shift right by 1 bit
			q[3] <= q[4] ^ q[0]; // Tap at position 5 and XOR with the output bit (bit 0)
			q[2] <= q[3];
			q[1] <= q[2];
			q[0] <= q[1];
		end
	end
endmodule
