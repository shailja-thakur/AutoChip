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
		if (L) begin
			D <= R;
		end else if (E) begin
			D <= Q;
		end else begin
			D <= w;
		end
	end

	always @(posedge clk) begin
		if (L) begin
			Q <= D;
		end else if (E) begin
			Q <= D;
		end else begin
			Q <= Q;
		end
	end
endmodule
