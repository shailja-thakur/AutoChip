module top_module(
	input clk,
	input [7:0] in,
	output reg [7:0] pedge
);

	// Register to store value of previous input signal
	reg [7:0] d_last;

	// Always block triggered by the rising edge of the clock
	always @(posedge clk) begin
		// Store current input signal in d_last register
		d_last <= in;

		// Calculate output signal pedge
		pedge <= in & ~d_last;
	end

endmodule
