module top_module (
	input clk,
	input w,
	input R,
	input E,
	input L,
	output reg Q
);
	always @(posedge clk) begin
		if (L) // load value
			Q <= R;
		else if (E) // enable shift
			Q <= w;
	end
endmodule
