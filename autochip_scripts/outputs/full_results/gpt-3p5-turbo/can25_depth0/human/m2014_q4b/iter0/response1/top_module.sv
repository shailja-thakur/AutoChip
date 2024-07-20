module top_module (
	input clk,
	input d,
	input ar,
	output logic q
);
	reg q;
	always_ff @(posedge clk or negedge ar)
	begin
		if (ar == 0) // asynchronous reset
			q <= 0;
		else
			q <= d;
	end
endmodule
