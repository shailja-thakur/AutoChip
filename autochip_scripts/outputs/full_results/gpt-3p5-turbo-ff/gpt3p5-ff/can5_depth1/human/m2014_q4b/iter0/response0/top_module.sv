module top_module (
	input clk,
	input d,
	input ar,
	output logic q
);
	
	always_ff @(posedge clk or negedge ar) begin
		if (ar == 0) begin
			q <= 0;
		end else begin
			q <= d;
		end
	end
	
endmodule
