module top_module(
	input clk,
	input reset,
	input data,
	output reg start_shifting);

	reg [3:0] state;
	reg start_shifting;

	always @(posedge clk, posedge reset) begin
		if (reset) begin
			state <= 4'b0000;
			start_shifting <= 1'b0;
		end else begin
			case(state)
				4'b0000: // Initial state
					if (data) begin
						state <= 4'b0001; // Transition to state 1
					end
				4'b0001: // State 1
					if (data) begin
						state <= 4'b0010; // Transition to state 2
					end else begin
						state <= 4'b0000; // Transition back to initial state
					end
				4'b0010: // State 2
					if (data) begin
						state <= 4'b0011; // Transition to state 3
					end else begin
						state <= 4'b0000; // Transition back to initial state
					end
				4'b0011: // State 3
					if (!data) begin
						state <= 4'b0100; // Transition to state 4
					end else begin
						state <= 4'b0000; // Transition back to initial state
					end
				4'b0100: // State 4
					if (data) begin
						state <= 4'b0100; // Stay in state 4
						start_shifting <= 1'b1; // Start shifting
					end else begin
						state <= 4'b0000; // Transition back to initial state
					end
			endcase
		end
	end
endmodule
