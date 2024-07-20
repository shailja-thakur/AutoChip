module top_module (
	input clk,
	input reset,
	input in,
	output disc,
	output flag,
	output err);

	parameter S0 = 0;
	parameter S1 = 1;
	parameter S2 = 2;
	parameter S3 = 3;
	parameter S4 = 4;

	reg [2:0] state, next_state;
	reg disc_reg, flag_reg, err_reg;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state     <= S0;
			disc_reg  <= 0;
			flag_reg  <= 0;
			err_reg   <= 0;
		end else begin
			state     <= next_state;
			disc_reg  <= 0;
			flag_reg  <= 0;
			err_reg   <= 0;
		end
	end

	always @* begin
		disc      = disc_reg;
		flag      = flag_reg;
		err       = err_reg;

		case (state)
			S0: if (in) begin
					next_state = S1;
				end else begin
					next_state = S0;
				end
			S1: if (in) begin
					next_state = S2;
				end else begin
					next_state = S0;
				end
			S2: if (in) begin
					next_state = S3;
					flag_reg = 1;
				end else begin
					next_state = S0;
				end
			S3: if (in) begin
					next_state = S4;
					err_reg = 1;
				end else begin
					next_state = S0;
				end
			S4: if (in) begin
					next_state = S4;
					err_reg = 1;
				end else begin
					next_state = S0;
					disc_reg = 1;
				end
		endcase
	end
endmodule
