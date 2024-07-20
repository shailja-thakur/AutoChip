module top_module (
	input clk,
	input reset,
	input in,
	output disc,
	output flag,
	output err);

	reg [2:0] state, next_state;

	// Define states
	parameter IDLE = 3'b000;
	parameter CHECK_FLAG = 3'b001;
	parameter CHECK_DISC = 3'b010;
	parameter CHECK_ERR = 3'b011;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= IDLE;
		end else begin
			state <= next_state;
		end
	end

	always @(state or in) begin
		next_state = state;

		case (state)
			IDLE: begin
				if (in) begin
					next_state = CHECK_FLAG;
				end else begin
					next_state = IDLE;
				end
			end
			CHECK_FLAG: begin
				if (in) begin
					next_state = CHECK_DISC;
				end else begin
					next_state = IDLE;
				end
			end
			CHECK_DISC: begin
				if (in) begin
					next_state = CHECK_ERR;
				end else begin
					next_state = IDLE;
				end
			end
			CHECK_ERR: begin
				if (in) begin
					next_state = CHECK_ERR;
				end else begin
					next_state = IDLE;
				end
			end
			default: begin
				next_state = IDLE;
			end
		endcase

		// Output signals
		disc = 0;
		flag = 0;
		err = 0;

		case (state)
			CHECK_FLAG: begin
				if (next_state == IDLE) begin
					flag = 1;
				end
			end
			CHECK_DISC: begin
				if (next_state == IDLE) begin
					disc = 1;
				end
			end
			CHECK_ERR: begin
				if (next_state == IDLE) begin
					err = 1;
				end
			end
		endcase
	end
endmodule
