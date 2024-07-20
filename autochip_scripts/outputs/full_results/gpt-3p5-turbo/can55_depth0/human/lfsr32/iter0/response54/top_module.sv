module top_module(
	input clk,
	input reset,
	output reg [31:0] q);

	// Internal Signals
	reg [31:0] next_q;
	reg [31:0] lfsr;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			lfsr <= 32'h8000_0000; // Initializing the LFSR with 32'b10000000000000000000000000000000
			q <= 32'h1; // Reset the output q to 32'h1 when reset is active high
		end else begin
			lfsr <= next_q;
			q <= next_q[31]; // Output q is the MSB of the LFSR
		end
	end

	always @* begin
		next_q[0] = lfsr[31] ^ lfsr[21] ^ lfsr[1] ^ lfsr[0];
		next_q[1] = lfsr[0];
		next_q[2] = lfsr[1];
		next_q[3:31] = lfsr[2:30]; // Shifting the rest of the bits
	end

endmodule
