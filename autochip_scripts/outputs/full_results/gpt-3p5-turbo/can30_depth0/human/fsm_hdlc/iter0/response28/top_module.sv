module top_module (
	input clk,
	input reset,
	input in,
	output disc,
	output flag,
	output err);

	reg [2:0] state, next_state;
	parameter START = 0, S1 = 1, S2 = 2, S3 = 3, S4 = 4, S5 = 5;
	reg disc_out, flag_out, err_out;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= START;
			disc_out <= 0;
			flag_out <= 0;
			err_out <= 0;
		end else begin
			state <= next_state;
			disc_out <= 0;
			flag_out <= 0;
			err_out <= 0;
		end
	end

	always @(state or in) begin
		case (state)
			START: begin
				if (in) begin
					next_state = S1;
					disc_out = 0;
					flag_out = 0;
					err_out = 0;
				end else begin
					next_state = START;
					disc_out = 0;
					flag_out = 0;
					err_out = 0;
				end
			end

			S1: begin
				if (in) begin
					next_state = S2;
					disc_out = 0;
					flag_out = 0;
					err_out = 0;
				end else begin
					next_state = START;
					disc_out = 0;
					flag_out = 0;
					err_out = 0;
				end
			end

			S2: begin
				if (in) begin
					next_state = S3;
					disc_out = 0;
					flag_out = 0;
					err_out = 0;
				end else begin
					next_state = START;
					disc_out = 0;
					flag_out = 0;
					err_out = 0;
				end
			end

			S3: begin
				if (in) begin
					next_state = S4;
					disc_out = 0;
					flag_out = 0;
					err_out = 0;
				end else begin
					next_state = START;
					disc_out = 0;
					flag_out = 0;
					err_out = 0;
				end
			end

			S4: begin
				if (in) begin
					next_state = S5;
					disc_out = 0;
					flag_out = 0;
					err_out = 0;
				end else begin
					next_state = START;
					disc_out = 0;
					flag_out = 0;
					err_out = 0;
				end
			end

			S5: begin
				if (in) begin
					next_state = S5;
					disc_out = 0;
					flag_out = 0;
					err_out = 1;
				end else begin
					next_state = START;
					disc_out = 1;
					flag_out = 0;
					err_out = 0;
				end
			end
		endcase
	end

	assign disc = disc_out;
	assign flag = flag_out;
	assign err = err_out;

endmodule
