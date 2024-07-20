module top_module (
	input in,
	input [9:0] state,
	output reg [9:0] next_state,
	output reg out1,
	output reg out2);

	always @(*) begin
		out1 = 1'b0;
		out2 = 1'b0;
		next_state = 10'b0;

		case (1'b1) // use one-hot encoding
			state[0]: next_state = (in == 1'b0) ? 10'b0000000001 : 10'b0000000010;
			state[1]: next_state = (in == 1'b0) ? 10'b0000000001 : 10'b0000000100;
			state[2]: next_state = (in == 1'b0) ? 10'b0000000001 : 10'b0000001000;
			state[3]: next_state = (in == 1'b0) ? 10'b0000000001 : 10'b0000010000;
			state[4]: next_state = (in == 1'b0) ? 10'b0000000001 : 10'b0000100000;
			state[5]: next_state = (in == 1'b0) ? 10'b0001000000 : 10'b0001000000;
			state[6]: next_state = (in == 1'b0) ? 10'b0010000000 : 10'b0100000000;
			state[7]: begin
				next_state = (in == 1'b0) ? 10'b0000000001 : 10'b10000000;
				out2 = 1'b1;
			end
			state[8]: begin
				next_state = (in == 1'b0) ? 10'b0000000001 : 10'b0000000010;
				out1 = 1'b1;
			end
			state[9]: begin
				next_state = (in == 1'b0) ? 10'b0000000001 : 10'b0000000010;
				out1 = 1'b1;
				out2 = 1'b1;
			end
		endcase
	end
	
endmodule
