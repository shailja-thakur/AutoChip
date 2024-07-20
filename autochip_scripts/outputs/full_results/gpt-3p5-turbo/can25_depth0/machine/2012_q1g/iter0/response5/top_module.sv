module top_module (
	input [4:0] x,
	output logic f
);

	always_comb begin
		case (x)
			4'h0, 4'h1, 4'h4, 4'h5, 4'hc, 4'he: 
				f = 1;
			default:
				f = 0;
		endcase
	end

endmodule
