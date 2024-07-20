module top_module (
	input clock,
	input a, 
	output reg p,
	output reg q
);

always @(posedge clock) begin
	if (a) begin
		p <= 1'b0;
		q <= 1'b0;
	end else begin
		p <= q;
		q <= ~p;
	end
end

endmodule
