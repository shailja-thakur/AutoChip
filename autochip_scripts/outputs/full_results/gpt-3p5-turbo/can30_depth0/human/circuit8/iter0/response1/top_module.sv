module top_module (
	input clock,
	input a, 
	output reg p,
	output reg q
);

always @(posedge clock) begin
	if (a == 1) begin
		p <= 1;
		q <= 0;
	end else if (p == 1) begin
		p <= q;
		q <= 1;
	end else begin
		p <= 0;
		q <= 0;
	end
end
endmodule
