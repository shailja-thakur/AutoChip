module top_module(
    input clk,
    input reset,
    output reg [31:0] q);

	// Registers for LFSR
	reg [31:0] reg_q;
	reg [31:0] feedback;

	// Assign initial value
	assign q = reg_q;

	always @(posedge clk or posedge reset) begin
		// Reset condition
		if (reset) begin
			reg_q <= 32'h1;
		end else begin
			// XOR operation for feedback
			feedback = reg_q[31] ^ reg_q[21] ^ reg_q[1] ^ reg_q[0];

			// Shift values
			reg_q <= {reg_q[30:0], feedback};
		end
	end

endmodule
