module top_module (
	input clock,
	input a,
	output reg p,
	output reg q
);

	// Declare internal signals
	reg prev_clock;
	reg prev_a;

	// Always block for sequential logic
	always @(posedge clock) begin
		// Store previous values
		prev_clock <= clock;
		prev_a <= a;

		// State machine logics
		if (prev_clock == 0 && clock == 1) begin
			if (prev_a == 0) begin
				p <= 0;
				q <= 0;
			end else if (prev_a == 1) begin
				p <= 1;
				q <= 0;
			end
		end else if (prev_clock == 1 && clock == 0) begin
			if (prev_a == 0) begin
				p <= 0;
				q <= 1;
			end else if (prev_a == 1) begin
				p <= 1;
				q <= 1;
			end
		end else begin
			p <= p;
			q <= q;
		end
	end

endmodule
