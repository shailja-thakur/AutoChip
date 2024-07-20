module top_module (
	input clk,
	input reset,
	input in,
	output disc,
	output flag,
	output err);

	reg [2:0] state;
	reg disc_reg, disc_reg_reg, flag_reg, flag_reg_reg, err_reg, err_reg_reg;
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 3'b000; // reset state
		else
		begin
			case (state)
				3'b000: begin // State 0
					disc_reg_reg <= disc_reg;
					flag_reg_reg <= flag_reg;
					err_reg_reg <= err_reg;
					disc_reg <= 0;
					flag_reg <= 0;
					err_reg <= 0;
					if (in == 1)
						state <= 3'b001;
					else
						state <= 3'b000;
				end
				3'b001: begin // State 1
					disc_reg_reg <= disc_reg;
					flag_reg_reg <= flag_reg;
					err_reg_reg <= err_reg;
					if (in == 1)
						state <= 3'b010;
					else
						state <= 3'b000;
				end
				3'b010: begin // State 2
					disc_reg_reg <= disc_reg;
					flag_reg_reg <= flag_reg;
					err_reg_reg <= err_reg;
					if (in == 1)
						state <= 3'b011;
					else
						state <= 3'b000;
				end
				3'b011: begin // State 3
					disc_reg_reg <= disc_reg;
					flag_reg_reg <= flag_reg;
					err_reg_reg <= err_reg;
					if (in == 1)
						state <= 3'b100;
					else
						state <= 3'b000;
				end
				3'b100: begin // State 4
					disc_reg_reg <= disc_reg;
					flag_reg_reg <= flag_reg;
					err_reg_reg <= err_reg;
					if (in == 1)
						state <= 3'b101;
					else
						state <= 3'b000;
				end
				3'b101: begin // State 5
					disc_reg_reg <= disc_reg;
					flag_reg_reg <= flag_reg;
					err_reg_reg <= err_reg;
					if (in == 1)
						state <= 3'b110;
					else
						state <= 3'b010; // back to State 2
				end
				3'b110: begin // State 6
					disc_reg_reg <= disc_reg;
					flag_reg_reg <= flag_reg;
					err_reg_reg <= err_reg;
					if (in == 1)
						state <= 3'b111;
					else
						state <= 3'b010; // back to State 2
				end
				3'b111: begin // State 7
					disc_reg_reg <= disc_reg;
					flag_reg_reg <= flag_reg;
					err_reg_reg <= err_reg;
					if (in == 1)
						state <= 3'b111; // stay in State 7
					else
						state <= 3'b010; // back to State 2
				end
			endcase
		end
	end

	always @(posedge clk) begin
		case(state)
			3'b000: begin // State 0
				disc = disc_reg_reg;
				flag = flag_reg_reg;
				err = err_reg_reg;
			end
			3'b001: begin // State 1
				disc = disc_reg_reg;
				flag = flag_reg_reg;
				err = err_reg_reg;
			end
			3'b010: begin // State 2
				disc = disc_reg_reg;
				flag = flag_reg_reg;
				err = err_reg_reg;
			end
			3'b011: begin // State 3
				disc = disc_reg_reg;
				flag = flag_reg_reg;
				err = err_reg_reg;
			end
			3'b100: begin // State 4
				disc = disc_reg_reg;
				flag = flag_reg_reg;
				err = err_reg_reg;
			end
			3'b101: begin // State 5
				disc = disc_reg_reg;
				flag = flag_reg_reg;
				err = err_reg_reg;
			end
			3'b110: begin // State 6
				disc = disc_reg_reg;
				flag = flag_reg_reg;
				err = err_reg_reg;
			end
			3'b111: begin // State 7
				disc = disc_reg_reg;
				flag = flag_reg_reg;
				err = err_reg_reg;
			end
		endcase
	end

endmodule
