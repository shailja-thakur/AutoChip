module top_module (
	input clock,
	input a, 
	output reg p,
	output reg q
);

// Negative edge triggered always block
always @(negedge clock) begin
	q <= a;
end

// Level sensitive always block
always @(*) begin
	if (clock) begin
		p <= a;
	end
end

endmodule
