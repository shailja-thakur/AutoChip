module top_module (
	input clk,
	input w,
	input R,
	input E,
	input L,
	output reg Q
);

reg D;

always @ (posedge clk) begin
	if (E) begin
		if (L)
			D <= R;
		else
			D <= w;
	end
end

assign Q = D;

endmodule
