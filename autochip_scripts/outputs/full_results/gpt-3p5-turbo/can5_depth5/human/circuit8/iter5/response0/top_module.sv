module top_module (
	input wire clock,
	input wire a, 
	output reg p,
	output reg q
);

reg p_internal;
reg q_internal;

always @(posedge clock) begin
	if (a == 1'b0) begin
		p_internal <= 1'b0;
		q_internal <= 1'b0;
	end else if (a == 1'b1) begin
		p_internal <= 1'b1;
		q_internal <= 1'b1;
	end else begin
		p_internal <= p_internal;
		q_internal <= q_internal;
	end
end

always @(posedge clock) begin
	p <= p_internal;
	q <= q_internal;
end

endmodule
