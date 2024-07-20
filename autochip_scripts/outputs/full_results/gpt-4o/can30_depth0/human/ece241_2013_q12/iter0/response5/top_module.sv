module top_module (
	input clk,
	input enable,
	input S,
	input A,
	input B,
	input C,
	output reg Z
);

	// Declare the shift register array
	reg [7:0] Q;

	// Shift register logic
	always @(posedge clk) begin
		if (enable)
			Q <= {Q[6:0], S};  // Shift in the new bit S into Q[0]
	end

	// MUX to set output Z based on inputs A, B, and C
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
			default: Z = 1'b0;  // Should never happen, but good to have a default 
		endcase
	end

endmodule
