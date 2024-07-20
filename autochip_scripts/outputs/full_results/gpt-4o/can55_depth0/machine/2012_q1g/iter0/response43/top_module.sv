module top_module (
	input [4:0] x,
	output logic f
);

	always @(*) begin
		case (x)
			5'h0: f = 1;
			5'h1: f = 1;
			5'h2: f = 0;
			5'h3: f = 0;
			5'h4: f = 1;
			5'h5: f = 1;
			5'h6: f = 1;
			5'h7: f = 0;
			5'h8: f = 0;
			5'h9: f = 0;
			5'hA: f = 0;
			5'hB: f = 0;
			5'hC: f = 1;
			5'hD: f = 0;
			5'hE: f = 1;
			5'hF: f = 1;
			default: f = 1'b0; // Default case to handle other values of x if needed
		endcase
	end

endmodule
