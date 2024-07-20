module top_module (
	input in,
	input [9:0] state,
	output reg [9:0] next_state,
	output reg out1,
	output reg out2);

	always @* begin
		case(state)
			10'b0000000001: begin next_state[9:0] = 10'b0000000001; end // S0, input 0
			10'b0000000010: begin next_state[9:0] = 10'b0000000001; end // S1, input 0
			10'b0000000011: begin next_state[9:0] = 10'b0000000001; end // S2, input 0
			10'b0000000100: begin next_state[9:0] = 10'b0000000001; end // S3, input 0
			10'b0000000101: begin next_state[9:0] = 10'b0000000001; end // S4, input 0
			10'b0000000110: begin next_state[9:0] = 10'b0000001000; end // S5, input 0
			10'b0000000111: begin next_state[9:0] = 10'b0000001001; end // S6, input 0
			10'b0000001000: begin next_state[9:0] = 10'b0000000001; end // S7, input 0
			10'b0000001001: begin next_state[9:0] = 10'b0000000001; end // S8, input 0
			10'b0000001010: begin next_state[9:0] = 10'b0000000001; end // S9, input 0
			default: begin next_state[9:0] = 10'b0000000000; end // Default case to handle undefined state
		endcase
	end

	always @* begin
		case(state)
			10'b0000000110: begin out1 = 1'b1; out2 = 1'b0; end // S5 output
			10'b0000000111: begin out1 = 1'b0; out2 = 1'b1; end // S6 output
			default: begin out1 = 1'b0; out2 = 1'b0; end // Default output
		endcase
	end

endmodule
