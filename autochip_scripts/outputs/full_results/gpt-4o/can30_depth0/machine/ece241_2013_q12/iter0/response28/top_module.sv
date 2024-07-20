module top_module (
	input clk,
	input enable,
	input S,
	input A,
	input B,
	input C,
	output reg Z
);

	// 8-bit register
	reg [7:0] q;

	// Always block for the shift register
	always @(posedge clk) begin
		if (enable) begin
			// Shift the register and input the new bit from S
			q <= {q[6:0], S};
		end
	end

	// Always block for the multiplexer
	always @(*) begin
		case ({A, B, C})
			3'b000: Z = q[0];
			3'b001: Z = q[1];
			3'b010: Z = q[2];
			3'b011: Z = q[3];
			3'b100: Z = q[4];
			3'b101: Z = q[5];
			3'b110: Z = q[6];
			3'b111: Z = q[7];
			default: Z = 1'b0;  // Default case (although technically not needed for a full case cover)
		endcase
	end

endmodule
