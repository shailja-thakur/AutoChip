module top_module(
	input clk,
	input reset,
	output reg [31:0] q);

	// Internal wires
	wire [31:0] next_state;
	
	// Bit taps
	assign next_state[0] = q[31] ^ q[21] ^ q[1] ^ q[0]; // Tap at position 32, 22, 2, and 1
	
	// Clock and Reset logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			q <= 32'b1; // Reset output q to 32'h1
		end else begin
			q <= next_state;
		end
	end

endmodule
