module top_module(
	input clk,
	input reset,
	output reg [31:0] q);

	// Internal signals
	reg [31:0] shift_reg;
	reg tap_bit;

	// Bit positions with taps
	reg feedback_bit_32;
	reg feedback_bit_22;
	reg feedback_bit_2;
	reg feedback_bit_1;

	// Tap bit calculations
	assign feedback_bit_32 = shift_reg[31] ^ tap_bit;
	assign feedback_bit_22 = shift_reg[21] ^ tap_bit;
	assign feedback_bit_2 = shift_reg[1] ^ tap_bit;
	assign feedback_bit_1 = shift_reg[0] ^ tap_bit;

	// Next state calculation
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			shift_reg <= 32'b1;
		end else begin
			shift_reg[31:1] <= {feedback_bit_32, shift_reg[30:1]};
			shift_reg[0] <= feedback_bit_1;
		end
	end

	// Output assignment
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			q <= 32'h1;
		end else begin
			q <= shift_reg;
		end
	end
endmodule
