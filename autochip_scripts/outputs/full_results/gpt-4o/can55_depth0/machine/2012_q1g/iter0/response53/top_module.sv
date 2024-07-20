module top_module (
	input [4:0] x,
	output logic f
);

	always_comb begin
		case (x)
			5'h0: f = 1'b1;
			5'h1: f = 1'b1;
			5'h2: f = 1'b0;
			5'h3: f = 1'b0;
			5'h4: f = 1'b1;
			5'h5: f = 1'b1;
			5'h6: f = 1'b1;
			5'h7: f = 1'b0;
			5'h8: f = 1'b0;
			5'h9: f = 1'b0;
			5'hA: f = 1'b0;
			5'hB: f = 1'b0;
			5'hC: f = 1'b1;
			5'hD: f = 1'b0;
			5'hE: f = 1'b1;
			5'hF: f = 1'b1;
			default: f = 1'b0; // Default case to handle undefined states
		endcase
	end

endmodule
