module top_module (
	input clk,
	input reset,
	input in,
	output disc,
	output flag,
	output err);

	reg [2:0] state;
	reg disc, flag, err;
	reg prev_in;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 0;
			disc <= 0;
			flag <= 0;
			err <= 0;
			prev_in <= 0;
		end else begin
			case(state)
				0: begin
					if (in == 0)
						state <= 0;
					else if (in == 1)
						state <= 1;
				end
				1: begin
					if (in == 0)
						state <= 2;
					else if (in == 1)
						state <= 1;
				end
				2: begin
					if (in == 0)
						state <= 0;
					else if (in == 1)
						state <= 3;
				end
				3: begin
					if (in == 0)
						state <= 4;
					else if (in == 1)
						state <= 3;
				end
				4: begin
					if (in == 0)
						state <= 0;
					else if (in == 1)
						state <= 5;
				end
				5: begin
					if (in == 0) begin
						state <= 0;
						disc <= 1;
					end else if (in == 1) begin
						state <= 6;
						flag <= 1;
					end
				end
				6: begin
					if (in == 0) begin
						state <= 0;
						flag <= 0;
					end else if (in == 1)
						state <= 7;
				end
				7: begin
					if (in == 0) begin
						state <= 0;
						err <= 1;
					end else if (in == 1)
						state <= 7;
				end
			endcase
			prev_in <= in;
		end
	end

endmodule
