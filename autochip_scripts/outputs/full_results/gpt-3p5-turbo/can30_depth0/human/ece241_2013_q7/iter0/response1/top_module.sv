module top_module (
	input clk,
	input j,
	input k,
	output reg Q
);

	always @(posedge clk)
	begin
		// Implementing the JK flip-flop functionality
		if (j && ~k)
			Q <= 1'b1;
		else if (~j && k)
			Q <= 1'b0;
		else if (j && k)
			Q <= ~Q;
		end
	end
  
endmodule
