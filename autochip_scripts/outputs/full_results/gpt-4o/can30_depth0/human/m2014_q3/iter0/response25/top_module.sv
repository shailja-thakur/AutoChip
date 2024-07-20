module top_module (
	input [4:1] x,
	output logic f
);

	always_comb begin
		case (x)
			4'b0000, 4'b0002, 4'b0003, 4'b0100, 4'b1000, 4'b1001, 4'b1100, 4'b1101: 
				f = 1'b0; // Minimized don't-care terms that result in 0
			4'b0010, 4'b0110, 4'b0111, 4'b1001, 4'b1010, 4'b1011, 4'b1111, 4'b1110:
				f = 1'b1; // Minimized don't-care terms that result in 1
			4'b0101, 4'b0011:
				f = 1'b0; // Terms explicitly stated as 0 in K-map
			4'b1110, 4'b1111, 4'b1000, 4'b1001:
				f = 1'b1; // Terms explicitly stated as 1 in K-map, rechecked
			default:
				f = 1'b0; // Default case, can be 0 or 1 based on convenience (minimized to 0 here)
		endcase
	end

endmodule
