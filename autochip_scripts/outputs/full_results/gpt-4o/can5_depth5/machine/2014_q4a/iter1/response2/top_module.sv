module top_module (
	input clk,
	input w,
	input R,
	input E,
	input L,
	output reg Q
);

	always @(posedge clk) begin
		if (R) begin
			Q <= 1'b0;
		end else if (E) begin
			if (L) begin
				Q <= R;  // This line updates Q with the value of R, although it resets to 0 as per the reset block
			end else begin
				Q <= w;
			end
		end
	end

endmodule
module top_module (
	input clk,
	input w,
	input R,
	input E,
	input L,
	output reg Q
);

	always @(posedge clk) begin
		if (R) begin
			Q <= 1'b0;
		end else if (E) begin
			if (L) begin
				Q <= 1;  // Update Q with logical high if L is high
			end else begin
				Q <= w;  // Update Q with w if L is low
			end
		end
	end

endmodule
