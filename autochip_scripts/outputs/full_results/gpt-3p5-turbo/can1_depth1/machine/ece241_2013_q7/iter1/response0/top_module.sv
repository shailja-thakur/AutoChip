module top_module (
	input clk,
	input j,
	input k,
	output reg Q
);

	always @(posedge clk) begin
		if (~j && ~k) // both j and k are low
			Q <= Q;
		else if (~j && k) // j is low and k is high
			Q <= 1'b0;
		else if (j && ~k) // j is high and k is low
			Q <= 1'b1;
		else if (j && k) // both j and k are high
			Q <= ~Q;
	end

endmodule
