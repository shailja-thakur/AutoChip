module top_module (
	input clock,
	input a, 
	output reg p,
	output reg q
);

	always @(posedge clock) begin
		if (a == 0) begin
			p <= 0;
		end else begin
			p <= 1;
		end
		
		if (a == 1) begin
			q <= 1;
		end else begin
			q <= 0;
		end
	end
endmodule
