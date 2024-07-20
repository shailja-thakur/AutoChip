module top_module (
	input clk,
	input w,
	input R,
	input E,
	input L,
	output reg Q
);
  
	always @(posedge clk) begin
		if (E == 1'b0) begin
			// Output Q is held in its current state
		end else begin
			if (L == 1'b1) begin
				Q <= 1'b0; // Output Q is updated with the value of R
			end else begin
				Q <= w; // Output Q is updated with the value of w
			end
		end
	end

	initial begin
		Q = 1'b0;
	end

	always @(posedge clk) begin
		if (R == 1'b1) begin
			Q <= 1'b0; // Output Q is forced to a low state when R is high
		end
	end

endmodule
