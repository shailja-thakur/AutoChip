module top_module (
	input clk,
	input d,
	input ar,
	output logic q
);
	always @(posedge clk or posedge ar) begin
		if (ar)
			q <= 1'b0;
		else if (clk)
			q <= d;
	end
endmodule
