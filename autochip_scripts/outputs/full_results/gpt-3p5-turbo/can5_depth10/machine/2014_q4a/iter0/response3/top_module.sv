module top_module (
	input clk,
	input w,
	input R,
	input E,
	input L,
	output reg Q
);

always @(posedge clk) begin
	if (E == 0) begin
		// Q is held in its current state
	end
	else begin
		if (L == 0)
			Q <= w;
		else
			Q <= R;
	end
end

endmodule
