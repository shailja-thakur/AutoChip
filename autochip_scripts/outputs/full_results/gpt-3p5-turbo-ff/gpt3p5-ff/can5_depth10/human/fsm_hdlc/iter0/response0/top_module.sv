module top_module (
	input clk,
	input reset,
	input in,
	output disc,
	output flag,
	output err);

reg [2:0] state;
reg prev_in, prev_prev_in;
reg next_disc, next_flag, next_err;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 0;
		prev_in <= 0;
		prev_prev_in <= 0;
		disc <= 0;
		flag <= 0;
		err <= 0;
	end else begin
		prev_in <= in;
		prev_prev_in <= prev_in;
		case (state)
			0: begin
				if (prev_in == 0 && prev_prev_in == 0 && in == 1)
					state <= 1;
				else
					state <= 0;
				disc <= 0;
				flag <= 0;
				err <= 0;
			end
			1: begin
				if (prev_in == 0 && prev_prev_in == 1 && in == 1)
					state <= 2;
				else if (prev_in == 0 && prev_prev_in == 0 && in == 1)
					state <= 1;
				else
					state <= 0;
				disc <= 0;
				flag <= 0;
				err <= 0;
			end
			2: begin
				if (prev_in == 1 && in == 1)
					state <= 3;
				else if (prev_in == 0 && prev_prev_in == 0 && in == 1)
					state <= 1;
				else
					state <= 0;
				disc <= 0;
				flag <= 0;
				err <= 0;
			end
			3: begin
				if (in == 1)
					state <= 4;
				else if (prev_in == 0 && prev_prev_in == 0 && in == 1)
					state <= 1;
				else
					state <= 0;
				disc <= 0;
				flag <= 0;
				err <= 0;
			end
			4: begin
				if (in == 1)
					state <= 5;
				else if (prev_in == 0 && prev_prev_in == 0 && in == 1)
					state <= 1;
				else
					state <= 0;
				disc <= 0;
				flag <= 0;
				err <= 0;
			end
			5: begin
				if (in == 1)
					state <= 6;
				else if (prev_in == 0 && prev_prev_in == 0 && in == 1)
					state <= 1;
				else
					state <= 0;
				disc <= 0;
				flag <= 0;
				err <= 0;
			end
			6: begin
				if (in == 0)
					state <= 7;
				else if (prev_in == 0 && prev_prev_in == 0 && in == 1)
					state <= 1;
				else
					state <= 0;
				disc <= 0;
				flag <= 0;
				err <= 0;
			end
			7: begin
				if (in == 1)
					state <= 8;
				else if (prev_in == 0 && prev_prev_in == 0 && in == 1)
					state <= 1;
				else
					state <= 0;
				disc <= 0;
				flag <= 0;
				err <= 0;
			end
			8: begin
				if (in == 1) begin
					state <= 8;
					next_disc <= 1;
				end else if (prev_in == 0 && prev_prev_in == 0 && in == 1)
					state <= 1;
				else begin
					state <= 0;
					next_disc <= 0;
				end
				flag <= 0;
				err <= 0;
			end
			9: begin
				if (in == 1) begin
					state <= 9;
					next_err <= 1;
				end else if (prev_in == 0 && prev_prev_in == 0 && in == 1)
					state <= 1;
				else begin
					state <= 0;
					next_err <= 0;
				end
				disc <= 0;
				flag <= 0;
			end
			default: begin
				state <= 0;
				prev_in <= 0;
				prev_prev_in <= 0;
				disc <= 0;
				flag <= 0;
				err <= 0;
			end
		endcase
	end
end

always @(posedge clk) begin
	disc <= next_disc;
	flag <= next_flag;
	err <= next_err;
end

endmodule
