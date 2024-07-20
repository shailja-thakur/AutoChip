module top_module (
	input wire clock,
	input wire a, 
	output reg p,
	output reg q
);
  
reg prev_a;
always @(posedge clock) begin
	if (a != prev_a && a == 1'b0) begin
		p <= 1'b0;
		q <= 1'b0;
	end else begin
		p <= a;
		q <= a;
	end
	prev_a <= a;
end

endmodule
