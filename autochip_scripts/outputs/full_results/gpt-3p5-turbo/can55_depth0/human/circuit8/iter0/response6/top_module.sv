module top_module (
	input clock,
	input a, 
	output reg p,
	output reg q
);

reg p_internal, q_internal;

always @(posedge clock) begin
	if (a) begin
		p_internal <= 1'b1;
	end else begin
		p_internal <= 1'b0;
	end
	
	if (p_internal) begin
		q_internal <= 1'b1;
	end else begin
		q_internal <= 1'b0;
	end
end

always @(posedge clock) begin
	if (a) begin
		p <= 1'b1;
	end else begin
		p <= 1'b0;
	end
end

always @(posedge clock) begin
	if (p_internal) begin
		q <= 1'b1;
	end else begin
		q <= 1'b0;
	end
end

endmodule
