module top_module (
	input clk,
	input reset,
	input in,
	output disc,
	output flag,
	output err);

	reg [3:0] state, next_state; // state register
	reg discard_flag, flag_flag, err_flag; // output flags

	// define states
	parameter IDLE = 0;
	parameter NEXT_1 = 1;
	parameter NEXT_2 = 2;
	parameter NEXT_3 = 3;
	parameter NEXT_4 = 4;
	parameter ERR = 5;

	// define state transitions and outputs
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= IDLE;
		end else begin
			state <= next_state;
		end
	end

	// define next state and output logic
	always @* begin
		next_state = state;
		discard_flag = 0;
		flag_flag = 0;
		err_flag = 0;

		case (state)
			IDLE: begin
				if (in) begin
					next_state = NEXT_1;
				end
			end

			NEXT_1: begin
				if (in) begin
					next_state = NEXT_2;
				end else begin
					next_state = IDLE;
				end
			end

			NEXT_2: begin
				if (in) begin
					next_state = NEXT_3;
				end else begin
					next_state = IDLE;
				end
			end

			NEXT_3: begin
				if (in) begin
					next_state = NEXT_4;
				end else begin
					next_state = IDLE;
				end
			end

			NEXT_4: begin
				if (in) begin
					next_state = ERR;
				end else begin
					next_state = IDLE;
				end
			end

			ERR: begin
				if (in) begin
					next_state = ERR;
				end else begin
					next_state = IDLE;
				end
			end
		endcase

		// set output flags
		case (state)
			IDLE: begin
				discard_flag = 0;
				flag_flag = 0;
				err_flag = 0;
			end

			NEXT_1: begin
				discard_flag = 0;
				flag_flag = 0;
				err_flag = 0;
			end

			NEXT_2: begin
				discard_flag = 0;
				flag_flag = 0;
				err_flag = 0;
			end

			NEXT_3: begin
				discard_flag = 0;
				flag_flag = 0;
				err_flag = 0;
			end

			NEXT_4: begin
				discard_flag = 1;
				flag_flag = 0;
				err_flag = 0;
			end

			ERR: begin
				discard_flag = 0;
				flag_flag = 0;
				err_flag = 1;
			end
		endcase
	end

	// assign output flags
	assign disc = discard_flag;
	assign flag = flag_flag;
	assign err = err_flag;

endmodule
