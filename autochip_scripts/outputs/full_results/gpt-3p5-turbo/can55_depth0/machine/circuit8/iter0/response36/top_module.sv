module top_module (
	input wire clock,
	input wire a, 
	output reg p,
	output reg q
);

always @(negedge clock) begin
	q <= a;
end

always @(a or clock) begin
	if (clock) begin
		p <= a;
	end
end

endmodule
