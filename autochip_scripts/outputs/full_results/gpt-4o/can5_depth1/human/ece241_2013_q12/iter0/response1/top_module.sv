module top_module (
	input clk,
	input enable,
	input S,
	input A,
	input B,
	input C,
	output reg Z
);

	// 8-bit shift register
	reg [7:0] Q;

	always @(posedge clk) begin
		if (enable)
			Q <= {S, Q[7:1]}; // Shift in the new bit S
	end

	// 3-to-8 Decoder using A, B, C as inputs to select the correct bit from Q
	always @(*) begin
		case ({A, B, C})
			3'b000: Z = Q[0];
			3'b001: Z = Q[1];
			3'b010: Z = Q[2];
			3'b011: Z = Q[3];
			3'b100: Z = Q[4];
			3'b101: Z = Q[5];
			3'b110: Z = Q[6];
			3'b111: Z = Q[7];
			default: Z = 1'b0; // Default case, although logically this shouldn't happen
		endcase
	end

endmodule
