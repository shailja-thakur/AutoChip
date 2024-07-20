module top_module (
	input clock,
	input a, 
	output reg p,
	output reg q
);
  
	always @(negedge clock) begin
		q <= a;
	end

	always @(posedge clock or a) begin
		if (clock == 1'b1) begin
			p <= a;
		end
	end

endmodule
