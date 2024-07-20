module top_module (
	input in,
	input [9:0] state,
	output [9:0] next_state,
	output out1,
	output out2);

	reg [9:0] next_state_reg; // Register to hold next state temporarily

	// Assign next_state based on current state and input
	always @* begin
		case(state)
			10'b0000000001: next_state_reg = 10'b0000000001; // S0, input 0
			10'b0000000001: next_state_reg = 10'b0000000010; // S0, input 1
			10'b0000000010: next_state_reg = 10'b0000000001; // S1, input 0
			10'b0000000010: next_state_reg = 10'b0000000011; // S1, input 1
			10'b0000000011: next_state_reg = 10'b0000000001; // S2, input 0
			10'b0000000011: next_state_reg = 10'b0000000100; // S2, input 1
			10'b0000000100: next_state_reg = 10'b0000000001; // S3, input 0
			10'b0000000100: next_state_reg = 10'b0000000101; // S3, input 1
			10'b0000000101: next_state_reg = 10'b0000000001; // S4, input 0
			10'b0000000101: next_state_reg = 10'b0000000110; // S4, input 1
			10'b0000000110: next_state_reg = 10'b0000001000; // S5, input 0
			10'b0000000110: next_state_reg = 10'b0000000111; // S5, input 1
			10'b0000000111: next_state_reg = 10'b0000001001; // S6, input 0
			10'b0000000111: next_state_reg = 10'b0000001000; // S6, input 1
			10'b0000001000: next_state_reg = 10'b0000000001; // S7, input 0
			10'b0000001000: next_state_reg = 10'b0000001000; // S7, input 1
			10'b0000001001: next_state_reg = 10'b0000000001; // S8, input 0
			10'b0000001001: next_state_reg = 10'b0000000010; // S8, input 1
			10'b0000001010: next_state_reg = 10'b0000000001; // S9, input 0
			10'b0000001010: next_state_reg = 10'b0000000010; // S9, input 1
			default: next_state_reg = 10'b0000000000; // Default case to handle undefined state
		endcase
	end

	// Assign outputs based on current state
	assign out1 = (state == 10'b0000000110) ? 1 : 0; // S5 output
	assign out2 = (state == 10'b0000000111) ? 1 : 0; // S6 output

	// Assign outputs to next_state
	always @(posedge clk) begin
		next_state <= next_state_reg;
	end

endmodule
