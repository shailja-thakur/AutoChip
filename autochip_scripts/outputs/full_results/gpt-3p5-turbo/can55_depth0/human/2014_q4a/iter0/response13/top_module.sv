module top_module (
	input clk,
	input w,
	input R,
	input E,
	input L,
	output reg Q
);

	reg D;

	always @(posedge clk) begin
		if (E)
			D <= R;
		else if (L)
			D <= w;
	end

	assign Q = D;

endmodule
