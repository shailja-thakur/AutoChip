module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output out
);

	// State variable to keep track of the current state
	reg [1:0] state;

	// Next state logic
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 2'b00;  // State A
		else begin
			if (state == 2'b00) begin
				if (j)
					state <= 2'b01;  // State B
				else
					state <= 2'b00;  // State A
			end else begin
				if (k)
					state <= 2'b00;  // State A
				else
					state <= 2'b01;  // State B
			end
		end
	end

	// Output logic
	assign out = (state == 2'b01) ? 1'b1 : 1'b0;

endmodule
