module top_module (
	input clock,
	input a, 
	output reg p,
	output reg q
);

	always @(posedge clock or negedge clock) begin
		if (clock) begin
			// Update p on the positive edge of the clock
			if (a == 1) p <= 1;
			else p <= 0;
		end 
		else begin
			// Update q on the negative edge of the clock
			q <= p;
		end
	end

endmodule
