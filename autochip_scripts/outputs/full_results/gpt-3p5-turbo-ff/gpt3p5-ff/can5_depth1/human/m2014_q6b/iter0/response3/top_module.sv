module top_module (
	input [3:1] y,
	input w,
	output reg Y2
);

	// Define the state codes
	parameter A = 3'b000;
	parameter B = 3'b001;
	parameter C = 3'b010;
	parameter D = 3'b011;
	parameter E = 3'b100;
	parameter F = 3'b101;
	
	always @(*) begin
		// Next state logic for Y2
		case (y)
			A: Y2 = 1'b0;
			B: Y2 = 1'b1;
			C: Y2 = 1'b0;
			D: Y2 = 1'b1;
			E: Y2 = 1'b1;
			F: Y2 = 1'b0;
			default: Y2 = 1'b0;
		endcase
	end
endmodule
