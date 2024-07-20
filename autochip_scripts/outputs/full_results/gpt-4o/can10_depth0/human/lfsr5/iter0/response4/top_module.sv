module top_module(
	input clk,
	input reset,
	output reg [4:0] q);

always @(posedge clk or posedge reset) begin
	if (reset) begin
		q <= 5'b00001;  // Initialize the LFSR to 1 upon reset
	end else begin
	    // Implementing Galois LFSR with taps at bit positions 5 and 3
		q[0] <= q[4];             // Shift the output bit
		q[1] <= q[0];             // Shift the next bit
		q[2] <= q[1];             // Shift the next bit
		q[3] <= q[2] ^ q[4];      // XOR tap
		q[4] <= q[3];             // Shift the next bit
	end
end

endmodule
