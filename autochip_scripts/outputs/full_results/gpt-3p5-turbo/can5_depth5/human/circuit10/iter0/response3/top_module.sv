module top_module (
	input clk,
	input a,
	input b,
	output q,
	output state
);

reg q;
reg state;

always @(posedge clk) begin
	state <= a & b;
	if (state == 2'b00) begin
		q <= 1'b0;
	end else if (state == 2'b01) begin
		q <= 1'b1;
	end else if (state == 2'b10) begin
		q <= 1'b0;
	end else begin
		q <= 1'b1;
	end
end
endmodule
