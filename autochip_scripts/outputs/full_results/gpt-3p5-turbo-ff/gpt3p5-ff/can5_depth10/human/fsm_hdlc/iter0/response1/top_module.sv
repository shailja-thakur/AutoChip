module top_module (
	input clk,
	input reset,
	input in,
	output disc,
	output flag,
	output err);

	// Define states
	typedef enum logic [2:0] {
		IDLE,
		ONE_ZERO,
		ONE_ONE,
		ONE_ERROR
	} state_t;

	// Define state registers
	reg state_t current_state, next_state;

	// Define outputs
	reg disc_out, flag_out, err_out;

	// Sequential logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			current_state <= IDLE;
		end else begin
			current_state <= next_state;
		end
	end

	// Combinational logic
	always @(*) begin
		case (current_state)
			IDLE:
				if (in) begin
					next_state = ONE_ZERO;
				end else begin
					next_state = IDLE;
				end
			ONE_ZERO:
				if (in) begin
					next_state = ONE_ONE;
				end else begin
					next_state = IDLE;
				end
			ONE_ONE:
				if (in) begin
					next_state = ONE_ERROR;
				end else begin
					next_state = IDLE;
				end
			ONE_ERROR:
				if (in) begin
					next_state = ONE_ERROR;
				end else begin
					next_state = IDLE;
				end
		endcase
	end

	// Output assignments
	assign disc = disc_out;
	assign flag = flag_out;
	assign err = err_out;

	// Output logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			disc_out <= 1'b0;
			flag_out <= 1'b0;
			err_out <= 1'b0;
		end else begin
			case (current_state)
				IDLE:
					disc_out <= 1'b0;
					flag_out <= 1'b0;
					err_out <= 1'b0;
				ONE_ZERO:
					disc_out <= 1'b1;
					flag_out <= 1'b0;
					err_out <= 1'b0;
				ONE_ONE:
					disc_out <= 1'b0;
					flag_out <= 1'b1;
					err_out <= 1'b0;
				ONE_ERROR:
					disc_out <= 1'b0;
					flag_out <= 1'b0;
					err_out <= 1'b1;
			endcase
		end
	end

endmodule
