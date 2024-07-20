module top_module (
	input wire clock,
	input wire a, 
	output reg p,
	output reg q
);

always @(posedge clock) begin
	if (a == 1'b0) begin
		p <= 1'b0;
		q <= 1'b0;
	end else begin
		p <= 1'b1; // fix: set p to 1 when a is high
		q <= p;
	end
end

endmodule
