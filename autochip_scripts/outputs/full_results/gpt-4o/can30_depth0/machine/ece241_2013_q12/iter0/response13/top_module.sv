module top_module (
	input clk,
	input enable,
	input S,
	input A,
	input B,
	input C,
	output reg Z
);

	// Internal 8-bit register
	reg [7:0] q;

	// Always block to shift the register contents on the rising edge of clk
	always @(posedge clk) begin
		if (enable) begin
			// Shift left operation
			q <= {q[6:0], S};
		end
	end

	// Always block to implement the 8-to-1 multiplexer
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
			default: Z = 1'b0;
		endcase
	end

endmodule
