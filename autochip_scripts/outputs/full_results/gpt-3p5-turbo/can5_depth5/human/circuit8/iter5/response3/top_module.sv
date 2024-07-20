module top_module (
	input wire clock,
	input wire a,
	output reg p,
	output reg q
);

reg prev_a;

always @(posedge clock) begin
	prev_a <= a;
	if (prev_a == 1'b0) begin
		p <= 1'b0;
		q <= 1'b0;
	end else begin
		p <= 1'b1;
		q <= 1'b1;
	end
end

endmodule
