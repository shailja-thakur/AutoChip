module top_module (
	input clk,
	input reset,
	input in,
	output disc,
	output flag,
	output err); 

	reg [2:0] state;
	reg disc_reg, flag_reg, err_reg;
	reg pre_in;
	reg [4:0] ones_count_reg;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 0;
			disc_reg <= 0;
			flag_reg <= 0;
			err_reg <= 0;
			ones_count_reg <= 0;
			pre_in <= 0;
		end else begin
			case(state)
				0: begin
					if (in & ~pre_in) begin
						state <= 1;
						ones_count_reg <= 1;
						disc_reg <= 0;
					end else begin
						state <= 0;
						ones_count_reg <= 0;
						disc_reg <= 0;
					end
				end
				1: begin
					if (in) begin
						if (ones_count_reg == 6) begin
							state <= 2;
							ones_count_reg <= 0;
							flag_reg <= 1;
						end else if (ones_count_reg >= 7) begin
							state <= 0;
							ones_count_reg <= 0;
							err_reg <= 1;
						end else begin
							state <= 1;
							ones_count_reg <= ones_count_reg + 1;
							disc_reg <= 1;
						end
					end else begin
						state <= 0;
						ones_count_reg <= ones_count_reg + 1;
						disc_reg <= 0;
					end
				end
				2: begin
					if (in) begin
						if (ones_count_reg == 0) begin
							state <= 1;
							ones_count_reg <= ones_count_reg + 1;
							disc_reg <= 0;
						end else begin
							state <= 2;
							ones_count_reg <= ones_count_reg + 1;
							flag_reg <= 1;
						end
					end else begin
						state <= 0;
						disc_reg <= 0;
					end
				end
			endcase
		end
		pre_in <= in;
	end

	assign disc = disc_reg;
	assign flag = flag_reg;
	assign err = err_reg;

endmodule
