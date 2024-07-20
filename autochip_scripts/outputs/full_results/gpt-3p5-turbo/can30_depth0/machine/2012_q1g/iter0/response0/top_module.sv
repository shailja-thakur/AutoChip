module top_module (
	input [4:0] x,     // <-- Corrected the range of the input x
	output logic f
);

	always_comb begin  // <-- Changed to always_comb instead of always 
		case (x)	    // <-- Removed the range specification in the case statement
			4'b0000: f = 1;   // <-- Fixed the case values and assigned outputs accordingly
			4'b0001: f = 1;
			4'b0010: f = 0;
			4'b0011: f = 0;
			4'b0100: f = 1;
			4'b0101: f = 1;
			4'b0110: f = 1;
			4'b0111: f = 0;
			4'b1000: f = 0;
			4'b1001: f = 0;
			4'b1010: f = 0;
			4'b1011: f = 0;
			4'b1100: f = 1;
			4'b1101: f = 0;
			4'b1110: f = 1;
			4'b1111: f = 1;
		endcase
	end
endmodule
