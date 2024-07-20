module top_module (
	input in,
	input [9:0] state,
	output [9:0] next_state,
	output reg out1,
	output reg out2);

	always @* begin
		case(state)
			10'b0000000001: begin // S0 (0, 0) --0--> S0
				next_state = 10'b0000000001;
				out1 = 1'b0;
				out2 = 1'b0;
			end
			10'b0000000001: begin // S0 (0, 0) --1--> S1
				next_state = 10'b0000000010;
				out1 = 1'b0;
				out2 = 1'b0;
			end
			10'b0000000010: begin // S1 (0, 0) --0--> S0
				next_state = 10'b0000000001;
				out1 = 1'b0;
				out2 = 1'b0;
			end
			10'b0000000010: begin // S1 (0, 0) --1--> S2
				next_state = 10'b0000000011;
				out1 = 1'b0;
				out2 = 1'b0;
			end
			10'b0000000011: begin // S2 (0, 0) --0--> S0
				next_state = 10'b0000000001;
				out1 = 1'b0;
				out2 = 1'b0;
			end
			10'b0000000011: begin // S2 (0, 0) --1--> S3
				next_state = 10'b0000000100;
				out1 = 1'b0;
				out2 = 1'b0;
			end
			10'b0000000100: begin // S3 (0, 0) --0--> S0
				next_state = 10'b0000000001;
				out1 = 1'b0;
				out2 = 1'b0;
			end
			10'b0000000100: begin // S3 (0, 0) --1--> S4
				next_state = 10'b0000000101;
				out1 = 1'b0;
				out2 = 1'b0;
			end
			10'b0000000101: begin // S4 (0, 0) --0--> S0
				next_state = 10'b0000000001;
				out1 = 1'b0;
				out2 = 1'b0;
			end
			10'b0000000101: begin // S4 (0, 0) --1--> S5
				next_state = 10'b0000000110;
				out1 = 1'b0;
				out2 = 1'b0;
			end
			10'b0000000110: begin // S5 (0, 0) --0--> S8
				next_state = 10'b0000001000;
				out1 = 1'b0;
				out2 = 1'b0;
			end
			10'b0000000110: begin // S5 (0, 0) --1--> S6
				next_state = 10'b0000000111;
				out1 = 1'b0;
				out2 = 1'b0;
			end
			10'b0000000111: begin // S6 (0, 0) --0--> S9
				next_state = 10'b0000001001;
				out1 = 1'b0;
				out2 = 1'b0;
			end
			10'b0000000111: begin // S6 (0, 0) --1--> S7
				next_state = 10'b0000001100;
				out1 = 1'b0;
				out2 = 1'b0;
			end
			10'b0000001100: begin // S7 (0, 1) --0--> S0
				next_state = 10'b0000000001;
				out1 = 1'b0;
				out2 = 1'b1;
			end
			10'b0000001100: begin // S7 (0, 1) --1--> S7
				next_state = 10'b0000001100;
				out1 = 1'b0;
				out2 = 1'b1;
			end
			10'b0000001000: begin // S8 (1, 0) --0--> S0
				next_state = 10'b0000000001;
				out1 = 1'b1;
				out2 = 1'b0;
			end
			10'b0000001000: begin // S8 (1, 0) --1--> S1
				next_state = 10'b0000000010;
				out1 = 1'b1;
				out2 = 1'b0;
			end
			10'b0000001001: begin // S9 (1, 1) --0--> S0
				next_state = 10'b0000000001;
				out1 = 1'b1;
				out2 = 1'b1;
			end
			10'b0000001001: begin // S9 (1, 1) --1--> S1
				next_state = 10'b0000000010;
				out1 = 1'b1;
				out2 = 1'b1;
			end
			default: begin
				next_state = 10'b0;
				out1 = 1'b0;
				out2 = 1'b0;
			end
		endcase
	end

endmodule
