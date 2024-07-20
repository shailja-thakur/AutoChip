module top_module (
	input in,
	input [9:0] state,
	output [9:0] next_state,
	output out1,
	output out2);

	// Assign next_state based on current state and input
	always @* begin
		case(state)
			10'b0000000001: next_state = 10'b0000000001; // S0, input 0
			10'b0000000001: next_state = 10'b0000000010; // S0, input 1
			10'b0000000010: next_state = 10'b0000000001; // S1, input 0
			10'b0000000010: next_state = 10'b0000000011; // S1, input 1
			10'b0000000011: next_state = 10'b0000000001; // S2, input 0
			10'b0000000011: next_state = 10'b0000000100; // S2, input 1
			10'b0000000100: next_state = 10'b0000000001; // S3, input 0
			10'b0000000100: next_state = 10'b0000000101; // S3, input 1
			10'b0000000101: next_state = 10'b0000000001; // S4, input 0
			10'b0000000101: next_state = 10'b0000000110; // S4, input 1
			10'b0000000110: next_state = 10'b0000001000; // S5, input 0
			10'b0000000110: next_state = 10'b0000000111; // S5, input 1
			10'b0000000111: next_state = 10'b0000001001; // S6, input 0
			10'b0000000111: next_state = 10'b0000001000; // S6, input 1
			10'b0000001000: next_state = 10'b0000000001; // S7, input 0
			10'b0000001000: next_state = 10'b0000001000; // S7, input 1
			10'b0000001001: next_state = 10'b0000000001; // S8, input 0
			10'b0000001001: next_state = 10'b0000000010; // S8, input 1
			10'b0000001010: next_state = 10'b0000000001; // S9, input 0
			10'b0000001010: next_state = 10'b0000000010; // S9, input 1
			default: next_state = 10'b0000000000; // Default case to handle undefined state
		endcase
	end

	reg out1_reg, out2_reg; // Registers for the outputs

	// Assign outputs based on current state
	always @(state) begin
		case(state)
			10'b0000000110: begin // S5 output
				out1_reg = 1;
				out2_reg = 0;
			end
			10'b0000000111: begin // S6 output
				out1_reg = 0;
				out2_reg = 1;
			end
			default: begin
				out1_reg = 0;
				out2_reg = 0;
			end
		endcase
	end

	// Assign outputs from registers
	assign out1 = out1_reg;
	assign out2 = out2_reg;

endmodule
