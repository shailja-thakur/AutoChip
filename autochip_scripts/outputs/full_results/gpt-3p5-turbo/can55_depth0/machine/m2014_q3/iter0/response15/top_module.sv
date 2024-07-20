module top_module (
	input [4:1] x,
	output logic f
);

	always_comb begin
	
		if (x == 4'h2 || x == 4'h6 || x == 4'h7 || x == 4'h8 || x == 4'h9 || x == 4'hb || x == 4'hc || x == 4'he) begin
			f = 1'b0;
		end else if (x == 4'h4) begin
			f = 1'b1;
		end else begin
			f = 1'bx;
		end
	
	end
	
endmodule
