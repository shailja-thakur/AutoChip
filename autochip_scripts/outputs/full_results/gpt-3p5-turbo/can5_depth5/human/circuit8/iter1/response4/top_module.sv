module top_module (
	input wire clock,
	input wire a, 
	output reg p,
	output reg q
);

reg temp;

always @(posedge clock) begin
	if (a == 1'b0) begin
		p <= 1'b0;
		q <= 1'b0;
	end else begin
		temp <= a;
		p <= temp;
		q <= a;
	end
end

endmodule
