module top_module (
	input clock,
	input a, 
	output reg p,
	output reg q
);

	// State variable to hold the previous value of `a`
	reg prev_a;
	
	// Sequential logic block
	always @(posedge clock) begin
		// On the rising edge of the clock
		p <= a;
		if (a == 1)
			q <= 0;
		else if (prev_a == 1)
			q <= 1;
	end

	// Update the state variable `prev_a` on the falling edge of the clock
	always @(negedge clock) begin
		prev_a <= a;
	end

endmodule
