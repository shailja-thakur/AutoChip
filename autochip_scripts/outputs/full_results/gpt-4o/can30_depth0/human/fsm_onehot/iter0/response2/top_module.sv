module top_module (
	input in,
	input [9:0] state,
	output reg [9:0] next_state,
	output reg out1,
	output reg out2);

	always @(*) begin
		// Default assignments
		next_state = 10'b0;
		out1 = 0;
		out2 = 0;

		case (1'b1) // synthesis parallel_case
			state[0]: begin
				if (in == 1'b0)
					next_state = 10'b0000000001;
				else
					next_state = 10'b0000000010;
			end

			state[1]: begin
				if (in == 1'b0)
					next_state = 10'b0000000001;
				else
					next_state = 10'b0000000100;
			end

			state[2]: begin
				if (in == 1'b0)
					next_state = 10'b0000000001;
				else
					next_state = 10'b0000001000;
			end

			state[3]: begin
				if (in == 1'b0)
					next_state = 10'b0000000001;
				else
					next_state = 10'b0000010000;
			end

			state[4]: begin
				if (in == 1'b0)
					next_state = 10'b0000000001;
				else
					next_state = 10'b0000100000;
			end

			state[5]: begin
				if (in == 1'b0)
					next_state = 10'b1000000000;
				else
					next_state = 10'b0001000000;
			end

			state[6]: begin
				if (in == 1'b0)
					next_state = 10'b0100000000;
				else
					next_state = 10'b0010000000;
			end

			state[7]: begin
				if (in == 1'b0) begin
					next_state = 10'b0000000001;
					out2 = 1;
				end
				else begin
					next_state = 10'b0010000000;
					out2 = 1;
				end
			end

			state[8]: begin
				if (in == 1'b0) begin
					next_state = 10'b0000000001;
					out1 = 1;
				end
				else begin
					next_state = 10'b0000000010;
					out1 = 1;
				end
			end

			state[9]: begin
				if (in == 1'b0) begin
					next_state = 10'b0000000001;
					out1 = 1;
					out2 = 1;
				end
				else begin
					next_state = 10'b0000000010;
					out1 = 1;
					out2 = 1;
				end
			end

			default: begin
				next_state = 10'b0000000001;
				out1 = 0;
				out2 = 0;
			end
		endcase
	end

endmodule
