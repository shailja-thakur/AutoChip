module top_module (
	input clk,
	input w,
	input R,
	input E,
	input L,
	output reg Q
);

reg loaded_value;
reg shifted_value;

always @(posedge clk) begin
	if (L) begin
		loaded_value <= R;
	end else if (E) begin
		loaded_value <= shifted_value;
	end else begin
		loaded_value <= loaded_value;
	end
end

assign Q = loaded_value;

always @(posedge clk) begin
	if (w) begin
		shifted_value <= R;
	end else begin
		shifted_value <= Q;
	end
end

endmodule
