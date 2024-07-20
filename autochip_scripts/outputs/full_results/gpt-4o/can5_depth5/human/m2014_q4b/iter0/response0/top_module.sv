module top_module (
	input clk,
	input d,
	input ar,
	output logic q
);
	always_ff @(posedge clk or posedge ar) begin
		if (ar)
			q <= 1'b0; // Asynchronous reset
		else
			q <= d;
	end
endmodule
