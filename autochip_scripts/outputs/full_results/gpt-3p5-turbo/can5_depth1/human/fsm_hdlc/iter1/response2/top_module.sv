module top_module (
	input clk,
	input reset,
	input in,
	output disc,
	output flag,
	output err);

	reg [2:0] state;
	reg disc_reg, flag_reg, err_reg;
	assign disc = disc_reg;
	assign flag = flag_reg;
	assign err = err_reg;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 0;
			disc_reg <= 0;
			flag_reg <= 0;
			err_reg <= 0;
		end else begin
			case (state)
				0: if (in) begin
					   state <= 1;
					   disc_reg <= 0;
					   flag_reg <= 0;
					   err_reg <= 0;
				   end
				   else begin
					   state <= 0;
					   disc_reg <= 0;
					   flag_reg <= 0;
					   err_reg <= 0;
				   end
				1: if (in) begin
					   state <= 2;
					   disc_reg <= 0;
					   flag_reg <= 0;
					   err_reg <= 0;
				   end
				   else begin
					   state <= 0;
					   disc_reg <= 0;
					   flag_reg <= 0;
					   err_reg <= 0;
				   end
				2: if (in) begin
					   state <= 3;
					   disc_reg <= 0;
					   flag_reg <= 0;
					   err_reg <= 0;
				   end
				   else begin
					   state <= 4;
					   disc_reg <= 0;
					   flag_reg <= 0;
					   err_reg <= 0;
				   end
				3: if (in) begin
					   state <= 3;
					   disc_reg <= 0;
					   flag_reg <= 0;
					   err_reg <= 0;
				   end
				   else begin
					   state <= 0;
					   disc_reg <= 0;
					   flag_reg <= 0;
					   err_reg <= 0;
				   end
				4: if (in) begin
					   state <= 5;
					   disc_reg <= 0;
					   flag_reg <= 0;
					   err_reg <= 0;
				   end
				   else begin
					   state <= 0;
					   disc_reg <= 0;
					   flag_reg <= 0;
					   err_reg <= 0;
				   end
				5: if (in) begin
					   state <= 6;
					   disc_reg <= 0;
					   flag_reg <= 0;
					   err_reg <= 0;
				   end
				   else begin
					   state <= 0;
					   disc_reg <= 0;
					   flag_reg <= 0;
					   err_reg <= 0;
				   end
				6: if (in) begin
					   state <= 3;
					   disc_reg <= 0;
					   flag_reg <= 1;
					   err_reg <= 0;
				   end
				   else begin
					   state <= 7;
					   disc_reg <= 0;
					   flag_reg <= 0;
					   err_reg <= 0;
				   end
				7: begin
					   state <= 0;
					   disc_reg <= 0;
					   flag_reg <= 0;
					   err_reg <= 0;
				   end
				default: begin
							 state <= 0;
							 disc_reg <= 0;
							 flag_reg <= 0;
							 err_reg <= 0;
						 end
			endcase
		end
	end

endmodule
