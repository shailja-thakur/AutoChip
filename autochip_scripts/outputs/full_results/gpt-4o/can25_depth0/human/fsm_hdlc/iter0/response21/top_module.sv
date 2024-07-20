module top_module (
	input clk,
	input reset,
	input in,
	output reg disc,
	output reg flag,
	output reg err);

	// State encoding
	typedef enum reg [2:0] {
		S0 = 3'b000,
		S1 = 3'b001,
		S2 = 3'b010,
		S3 = 3'b011,
		S4 = 3'b100,
		S5 = 3'b101,
		S6 = 3'b110,
		ERR = 3'b111
	} state_t;

	state_t current_state, next_state;

	// State transition logic
	always @(posedge clk) begin
		if (reset) begin
			current_state <= S0;
		end else begin
			current_state <= next_state;
		end
	end

	// Next state logic
	always @( * ) begin
		next_state = current_state; // Default state transition
		disc = 0;
		flag = 0;
		err = 0;

		case (current_state)
			S0: begin
				if (in) next_state = S1; else next_state = S0;
			end
			S1: begin
				if (in) next_state = S2; else next_state = S0;
			end
			S2: begin
				if (in) next_state = S3; else next_state = S0;
			end
			S3: begin
				if (in) next_state = S4; else next_state = S0;
			end
			S4: begin
				if (in) next_state = S5; else next_state = S0;
			end
			S5: begin
				if (in) next_state = S6; else begin
					next_state = S0;
					disc = 1; // 0111110 detected
				end
			end
			S6: begin
				if (in) next_state = ERR; else begin
					next_state = S0;
					flag = 1; // 01111110 detected
				end
			end
			ERR: begin
				if (in) next_state = ERR; else next_state = S0;
				err = 1; // 01111111... detected
			end
			default: next_state = S0;
		endcase
		if (reset) begin
			disc = 0;
			flag = 0;
			err = 0;
		end
	end
endmodule
