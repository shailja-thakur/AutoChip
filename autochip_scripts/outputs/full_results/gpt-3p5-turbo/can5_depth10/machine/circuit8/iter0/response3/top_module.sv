module top_module (
	input clock,
	input a, 
	output reg p,
	output reg q
);
	// Assign q with a on negative edge of clock signal
	always @(negedge clock) begin
		q <= a;
	end
	
	// Assign p with a only when clock signal is high
	always @(posedge clock or a) begin
		if (clock == 1'b1) begin
			p <= a;
		end
	end

endmodule
