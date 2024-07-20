module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output out
);

	// Internal signals
	reg state;
	reg next_state;
	wire out_wire;

	// State assignments
	localparam A = 0;
	localparam B = 1;

	// State transition logic
	always @ (posedge clk, posedge reset) begin
		if (reset)
			state <= A;
		else
			state <= next_state;
	end

	// Next state logic
	always @ (*) begin
		if (state == A)
			if (j)
				next_state = B;
			else
				next_state = A;
		else
			if (k)
				next_state = A;
			else
				next_state = B;
	end

	// Output assignments
	assign out_wire = (state == B);

	// Output register
	always @ (posedge clk) begin
		out <= out_wire;
	end

endmodule
