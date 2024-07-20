module top_module (
	input clock,
	input a, 
	output reg p,
	output reg q
);

	reg d; // Adding d flip flop stage

	always @(posedge clock) begin
		if (a) begin
			d <= 1;
		end else begin
			d <= 0;
		end
	end
	
	always @(posedge clock) begin
		p <= d;
	end

	always @(negedge clock) begin
		q <= p;
	end

endmodule
