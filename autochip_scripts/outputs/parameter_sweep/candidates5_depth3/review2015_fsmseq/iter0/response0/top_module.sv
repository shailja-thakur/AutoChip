module top_module(
	input clk,
	input reset,
	input data,
	output start_shifting);

	// State register
	reg [2:0] state;

	// Next state logic
	always @(posedge clk)
	begin
		if (reset)
			state <= 0;
		else
		begin
			case (state)
				0: if (data) state <= 1; else state <= 0;
				1: if (data) state <= 2; else state <= 0;
				2: if (data) state <= 3; else state <= 0;
				3: if (data) begin state <= 3; start_shifting <= 1; end else state <= 0;
			endcase
		end
	end

	// Output logic
	always @*
	begin
		start_shifting = 0;
	end

endmodule
