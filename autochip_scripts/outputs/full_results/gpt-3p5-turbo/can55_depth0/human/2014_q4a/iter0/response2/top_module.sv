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
	begin
		if (L)
			D <= R;
		else
			D <= Q;
	end
	else
	begin
		if (L)
			D <= 1'b0;
		else
			D <= Q;
	end
end

always @(posedge clk) begin
	if (E)
	begin
		if (L)
			Q <= R;
		else
			Q <= D;
	end
	else
	begin
		if (L)
			Q <= 1'b0;
		else
			Q <= D;
	end
end

endmodule
