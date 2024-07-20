module top_module(
	input wire clk,
	input wire reset,
	output reg [31:0] q);

	// Declare a wire for the next value of the register
	wire [31:0] q_next;

	// Initial value of the register
	parameter INITIAL_VALUE = 32'h1;

	// Assign the initial value to the q register
	initial begin
		q = INITIAL_VALUE;
	end

	// Synchronize the register on the rising edge of the clk signal
	always @(posedge clk) begin
		if (reset) begin
			// Reset the register to the initial value
			q <= INITIAL_VALUE;
		end else begin
			// Update the q register with the value stored in the q_next register
			q <= q_next;
		end
	end

	// Update the q_next register on every clock cycle
	always @(posedge clk) begin
		// Shift the value of the q register by 1 bit
		q_next[31:0] = {q[30:0], q[31]};

		// XOR bits 21 and 1 with the value of bit 0
		q_next[21] = q[21] ^ (q[0] ^ q[31]);
		q_next[1] = q[1] ^ (q[0] ^ q[31]);

		// XOR bit 0 with the value of bit 0
		q_next[0] = q[0] ^ q[31];
	end

endmodule
