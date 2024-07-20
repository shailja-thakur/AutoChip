module top_module (
	input clk,
	input w,
	input R,
	input E,
	input L,
	output reg Q
);
	reg q_temp;
	
	always @(posedge clk) begin
		if (E) begin
			if (L) begin
				q_temp <= R;
			end else begin
				q_temp <= w;
			end
		end
	end
	
	always @(posedge clk) begin
		if (E) begin
			Q <= q_temp;
		end
	end
endmodule
