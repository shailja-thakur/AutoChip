module top_module (
	input clk,
	input x,
	input [2:0] y,
	output reg Y0,
	output reg z
);

	reg [2:0] Y;

	always @(posedge clk) begin
		case (y)
			3'b000: if (x) Y <= 3'b001; else Y <= 3'b000;
			3'b001: if (x) Y <= 3'b100; else Y <= 3'b001;
			3'b010: if (x) Y <= 3'b001; else Y <= 3'b010;
			3'b011: if (x) Y <= 3'b010; else Y <= 3'b001;
			3'b100: if (x) Y <= 3'b100; else Y <= 3'b011;
			default: Y <= 3'b000;
		endcase

		// Output z based on the current state
		case (y)
			3'b011: z <= 1;
			3'b100: z <= 1;
			default: z <= 0;
		endcase
	end
	
	// Assign Y0 to the least significant bit of Y
	assign Y0 = Y[0];

endmodule
