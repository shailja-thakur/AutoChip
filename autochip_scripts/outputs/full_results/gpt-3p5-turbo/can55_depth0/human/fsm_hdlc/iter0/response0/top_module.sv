module top_module (
	input clk,
	input reset,
	input in,
	output disc,
	output flag,
	output err);

	reg [2:0] state, next_state;

	parameter IDLE = 3'b000;
	parameter FOUND_DISC = 3'b001;
	parameter FOUND_FLAG = 3'b010;
	parameter FOUND_ERR = 3'b011;

	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= IDLE;
		else
			state <= next_state;
	end

	always @* begin
		next_state = state;
		disc = 0;
		flag = 0;
		err = 0;

		case (state)
			IDLE: begin
				if (in == 1)
					next_state = FOUND_DISC;
			end

			FOUND_DISC: begin
				if (in == 0)
					next_state = FOUND_FLAG;
				else if (in == 1)
					next_state = FOUND_ERR;
				disc = 1;
			end

			FOUND_FLAG: begin
				if (in == 0)
					next_state = IDLE;
				else if (in == 1)
					next_state = FOUND_ERR;
				flag = 1;
			end

			FOUND_ERR: begin
				if (in == 0)
					next_state = IDLE;
				else if (in == 1)
					next_state = FOUND_ERR;
				err = 1;
			end
		endcase
	end
endmodule
