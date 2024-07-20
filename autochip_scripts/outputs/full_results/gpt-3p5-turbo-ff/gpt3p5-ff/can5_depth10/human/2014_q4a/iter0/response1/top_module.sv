module top_module (
	input clk,
	input w,
	input R,
	input E,
	input L,
	output reg Q
);

reg D;
reg temp;

always @(posedge clk) begin
	if (E) begin
		D <= w;
	end else if (L) begin
		D <= R;
	end else begin
		D <= Q;
	end
end

always @(posedge clk) begin
	if (E) begin
		temp <= D;
	end else if (L) begin
		temp <= R;
	end else begin
		temp <= Q;
	end
end

always @(posedge clk) begin
	Q <= temp;
end

endmodule
