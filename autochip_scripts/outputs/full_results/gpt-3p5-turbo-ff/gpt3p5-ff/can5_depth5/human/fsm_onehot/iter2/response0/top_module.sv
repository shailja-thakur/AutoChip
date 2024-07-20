module top_module (
	input in,
	input [9:0] state,
	output reg [9:0] next_state,
	output reg out1, output reg out2);

	always @* begin
		case(state)
			10'b0000000001: begin next_state = 10'b0000000001; out1 = 1'b0; out2 = 1'b0; end // S0, input 0
			10'b0000000010: begin next_state = 10'b0000000001; out1 = 1'b0; out2 = 1'b0; end // S1, input 0
			10'b0000000011: begin next_state = 10'b0000000001; out1 = 1'b0; out2 = 1'b0; end // S2, input 0
			10'b0000000100: begin next_state = 10'b0000000001; out1 = 1'b0; out2 = 1'b0; end // S3, input 0
			10'b0000000101: begin next_state = 10'b0000000001; out1 = 1'b0; out2 = 1'b0; end // S4, input 0
			10'b0000000110: begin next_state = 10'b0000001000; out1 = 1'b0; out2 = 1'b0; end // S5, input 0
			10'b0000000111: begin next_state = 10'b0000001000; out1 = 1'b0; out2 = 1'b0; end // S6, input 0
			10'b0000001000: begin next_state = 10'b0000000001; out1 = 1'b0; out2 = 1'b1; end // S7, input 0
			10'b0000001001: begin next_state = 10'b0000000001; out1 = 1'b1; out2 = 1'b0; end // S8, input 0
			10'b0000001010: begin next_state = 10'b0000000001; out1 = 1'b1; out2 = 1'b1; end // S9, input 0
			default: begin next_state = 10'b0000000000; out1 = 1'b0; out2 = 1'b0; end // Default case to handle undefined state
		endcase
	end
endmodule
