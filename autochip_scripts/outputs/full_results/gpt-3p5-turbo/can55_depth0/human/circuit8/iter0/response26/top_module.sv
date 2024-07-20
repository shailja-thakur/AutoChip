module top_module (
	input clock,
	input a, 
	output reg p,
	output reg q
);

always @(posedge clock) begin
	if (a) begin
		p <= 1;
		q <= 0;
	end else if (p) begin
		p <= 1;
		q <= 1;
	end else if (q) begin
		p <= 0;
		q <= 0;
	end else begin
		p <= 0;
		q <= 0;
	end
end

endmodule
