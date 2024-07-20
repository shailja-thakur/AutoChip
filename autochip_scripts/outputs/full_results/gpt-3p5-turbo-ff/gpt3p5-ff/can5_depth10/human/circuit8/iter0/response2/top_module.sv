module top_module (
	input clock,
	input a, 
	output reg p,
	output reg q
);

always @(posedge clock) begin
	if (a) begin
		p <= 1'b1;
		q <= 1'b0;
	end else if (p & ~q) begin
		p <= 1'b0;
		q <= 1'b0;
	end else if (q) begin
		p <= 1'b1;
		q <= 1'b1;
	end else begin
		p <= 1'b0;
		q <= 1'b0;
	end
end

endmodule
