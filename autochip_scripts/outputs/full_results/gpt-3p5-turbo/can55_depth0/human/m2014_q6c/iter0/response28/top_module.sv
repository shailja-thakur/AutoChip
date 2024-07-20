module top_module (
	input [6:1] y,
	input w,
	output Y2,
	output Y4
);
	
	// Declare state variables
	reg A, B, C, D, E, F;
	
	// Next-state logic and state assignments
	always @(y)
	begin
		// Reset state
		A <= 1'b1;
		B <= 1'b0;
		C <= 1'b0;
		D <= 1'b0;
		E <= 1'b0;
		F <= 1'b0;
		
		case(y)
			6'b000001: begin // State A
				A <= w ? 1'b1 : 1'b0;
				B <= 1'b0;
			end
			
			6'b000010: begin // State B
				A <= w ? 1'b1 : 1'b0;
				B <= 1'b0;
				C <= 1'b0;
				D <= 1'b0;
			end
			
			6'b000100: begin // State C
				B <= w ? 1'b1 : 1'b0;
				C <= 1'b0;
				D <= 1'b0;
				E <= 1'b0;
			end
			
			6'b001000: begin // State D
				B <= w ? 1'b1 : 1'b0;
				D <= 1'b0;
				E <= 1'b0;
				F <= 1'b0;
			end
			
			6'b010000: begin // State E
				C <= w ? 1'b1 : 1'b0;
				E <= 1'b0;
				F <= 1'b0;
			end
			
			6'b100000: begin // State F
				D <= w ? 1'b1 : 1'b0;
				C <= 1'b0;
				D <= 1'b0;
				F <= 1'b0;
			end
		endcase
	end
	
	// Output signals
	assign Y2 = B ? 1'b1 : 1'b0;
	assign Y4 = D ? 1'b1 : 1'b0;
	
endmodule
