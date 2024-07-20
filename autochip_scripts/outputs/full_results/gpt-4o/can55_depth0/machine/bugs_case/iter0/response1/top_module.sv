module top_module (
	input [7:0] code,
	output reg [3:0] out,
	output reg valid
);

	always @(*) begin
		valid = 1'b0; // Default to invalid
		out = 4'b0000; // Default to 0

		case (code)
			8'h45: begin out = 4'h0; valid = 1'b1; end
			8'h16: begin out = 4'h1; valid = 1'b1; end
			8'h1E: begin out = 4'h2; valid = 1'b1; end
			8'h26: begin out = 4'h3; valid = 1'b1; end
			8'h25: begin out = 4'h4; valid = 1'b1; end
			8'h2E: begin out = 4'h5; valid = 1'b1; end
			8'h36: begin out = 4'h6; valid = 1'b1; end
			8'h3D: begin out = 4'h7; valid = 1'b1; end
			8'h3E: begin out = 4'h8; valid = 1'b1; end
			8'h46: begin out = 4'h9; valid = 1'b1; end
			default: begin out = 4'h0; valid = 1'b0; end
		endcase
	end

endmodule
