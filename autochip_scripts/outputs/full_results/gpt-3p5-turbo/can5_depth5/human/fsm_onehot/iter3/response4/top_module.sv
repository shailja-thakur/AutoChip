module top_module (
	input in,
	input [9:0] state,
	output [9:0] next_state,
	output reg out1,
	output reg out2);

	always @(*) begin
		case(state)
			10'b001_000_000: begin // S0
				if(in == 1'b0) begin
					next_state = 10'b001_000_001; // S1
				end
				else begin
					next_state = 10'b001_000_000; // S0
				end
			end
			10'b001_000_001: begin // S1
				if(in == 1'b0) begin
					next_state = 10'b001_000_000; // S0
				end
				else begin
					next_state = 10'b001_000_010; // S2
				end
			end
			10'b001_000_010: begin // S2
				if(in == 1'b0) begin
					next_state = 10'b001_000_000; // S0
				end
				else begin
					next_state = 10'b001_000_011; // S3
				end
			end
			10'b001_000_011: begin // S3
				if(in == 1'b0) begin
					next_state = 10'b001_000_000; // S0
				end
				else begin
					next_state = 10'b001_000_100; // S4
				end
			end
			10'b001_000_100: begin // S4
				if(in == 1'b0) begin
					next_state = 10'b001_000_000; // S0
				end
				else begin
					next_state = 10'b001_000_101; // S5
				end
			end
			10'b001_000_101: begin // S5
				if(in == 1'b0) begin
					next_state = 10'b001_000_100; // S4
				end
				else begin
					next_state = 10'b001_000_110; // S6
				end
			end
			10'b001_000_110: begin // S6
				if(in == 1'b0) begin
					next_state = 10'b001_000_100; // S4
				end
				else begin
					next_state = 10'b001_000_111; // S7
				end
			end
			10'b001_000_111: begin // S7
				if(in == 1'b0) begin
					next_state = 10'b001_000_000; // S0
				end
				else begin
					next_state = 10'b000_001_000; // S8
				end
			end
			10'b000_001_000: begin // S8
				if(in == 1'b0) begin
					next_state = 10'b001_000_001; // S1
				end
				else begin
					next_state = 10'b001_000_000; // S0
				end
			end
			10'b001_000_110: begin // S8
				if(in == 1'b0) begin
					next_state = 10'b001_000_001; // S1
				end
				else begin
					next_state = 10'b001_001_000; // S9
				end
			end
			10'b001_001_000: begin // S9
				if(in == 1'b0) begin
					next_state = 10'b001_000_001; // S1
				end
				else begin
					next_state = 10'b001_001_000; // S9
				end
			end
			default: begin
				next_state = 10'bxxx_xxx_xxx; // invalid state
			end
		endcase
	end

	always @(state) begin
		case(state)
			10'b001_111_111: begin // S0
				out1 = 1'b0;
				out2 = 1'b0;
			end
			10'b001_000_001: begin // S1
				out1 = 1'b0;
				out2 = 1'b0;
			end
			10'b001_000_010: begin // S2
				out1 = 1'b0;
				out2 = 1'b0;
			end
			10'b001_000_011: begin // S3
				out1 = 1'b0;
				out2 = 1'b0;
			end
			10'b001_000_100: begin // S4
				out1 = (state[8] == 1'b1) ? 1'b0 : 1'b1;
				out2 = (state[7] == 1'b1) ? 1'b0 : 1'b1;
			end
			10'b001_000_101: begin // S5
				out1 = (state[7] == 1'b1 && state[9] == 1'b0) ? 1'b1 : 1'b0;
				out2 = 1'b0;
			end
			10'b001_000_110: begin // S6
				out1 = (state[6] == 1'b1 && state[9] == 1'b0) ? 1'b1 : 1'b0;
				out2 = 1'b0;
			end
			10'b001_000_111: begin // S7
				out1 = (state[9] == 1'b1 && state[7] == 1'b1) ? 1'b1 : 1'b0;
				out2 = (state[9] == 1'b1 && state[7] == 1'b1) ? 1'b1 : 1'b0;
			end
			10'b000_001_000: begin // S8
				out1 = (state[9] == 1'b1 && state[8] == 1'b0) ? 1'b1 : 1'b0;
				out2 = 1'b0;
			end
			10'b001_001_000: begin // S9
				out1 = (state[9] == 1'b1 && state[8] == 1'b1 && state[7] == 1'b1) ? 1'b1 : 1'b0;
				out2 = (state[9] == 1'b1 && state[8] == 1'b1 && state[7] == 1'b1) ? 1'b1 : 1'b0;
			end
			default: begin
				out1 = 1'b0;
				out2 = 1'b0;
			end
		endcase
	end

endmodule
