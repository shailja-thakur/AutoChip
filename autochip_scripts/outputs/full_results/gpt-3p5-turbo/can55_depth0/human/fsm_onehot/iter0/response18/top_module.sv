module top_module (
	input in,
	input [9:0] state,
	output [9:0] next_state,
	output out1,
	output out2);

	reg [9:0] next_state;
	
	always @* begin
		case (state)
			10'b0000000001: next_state = 10'b0000000001; // S0 --> S0
			10'b0000000010: next_state = 10'b0000000011; // S0 --> S1
			10'b0000000011: next_state = 10'b0000000001; // S1 --> S0
			10'b0000000100: next_state = 10'b0000000101; // S1 --> S2
			10'b0000000101: next_state = 10'b0000000001; // S2 --> S0
			10'b0000000110: next_state = 10'b0000000111; // S2 --> S3
			10'b0000000111: next_state = 10'b0000000001; // S3 --> S0
			10'b0000001000: next_state = 10'b0000001001; // S3 --> S4
			10'b0000001001: next_state = 10'b0000000001; // S4 --> S0
			10'b0000001010: next_state = 10'b0000001011; // S4 --> S5
			10'b0000001011: next_state = 10'b0000001100; // S5 --> S8
			10'b0000011000: next_state = 10'b0000000001; // S5 --> S0
			10'b0000001100: next_state = 10'b0000001101; // S5 --> S6
			10'b0000001101: next_state = 10'b0000110100; // S6 --> S9
			10'b0000111110: next_state = 10'b0000000001; // S6 --> S0
			10'b0000110100: next_state = 10'b0000110101; // S6 --> S7
			10'b0000110101: next_state = 10'b0000000011; // S7 --> S1
			10'b0000000010: next_state = 10'b0000000001; // S7 --> S0
			10'b0000000001: next_state = 10'b0000000011; // S8 --> S1
			10'b0000000100: next_state = 10'b0000000001; // S8 --> S0
			10'b0000000111: next_state = 10'b0000000011; // S9 --> S1
			10'b0000000010: next_state = 10'b0000000001; // S9 --> S0
			default: next_state = 10'b0000000001;
		endcase
	end

	reg out1, out2;
	
	always @* begin
		case (state)
			10'b0000001101, 10'b0000110101: begin // S6, S7
				out1 = 0;
				out2 = 1;
			end
			10'b0000001011: begin // S5
				out1 = 1;
				out2 = 0;
			end
			default: begin
				out1 = 0;
				out2 = 0;
			end
		endcase
	end
endmodule
