module top_module (
	input clk,
	input w,
	input R,
	input E,
	input L,
	output reg Q
);

	always @(posedge clk) begin
		if (R)
			Q <= 1'b0; // Reset the register when R is high
		else if (E) // Enable the register operation
			if (L)
				Q <= R; // Load R value when L is high
			else
				Q <= w; // Load w value when L is low
	end
endmodule
