module top_module (
	input clk,
	input d,
	input ar,
	output logic q
);

	always_ff @(posedge clk or posedge ar) begin
		if (ar) begin
			q <= 1'b0;
		end else begin
			q <= d;
		end
	end
endmodule
