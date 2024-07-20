module top_module (
	input clk,
	input reset,
	input in,
	output reg disc,
	output reg flag,
	output reg err);

	// State encoding
	typedef enum reg [2:0] {
		IDLE = 3'd0,
		S1   = 3'd1,
		S2   = 3'd2,
		S3   = 3'd3,
		S4   = 3'd4,
		S5   = 3'd5,
		S6   = 3'd6,
		ERROR = 3'd7
	} state_t;

	state_t state, next_state;

	// FSM state transition
	always @(posedge clk) begin
		if (reset)
			state <= IDLE;
		else
			state <= next_state;
	end

	// FSM next state logic
	always @(*) begin
		case (state)
			IDLE: begin
				if (in)
					next_state = S1;
				else
					next_state = IDLE;
			end
			S1: begin
				if (in)
					next_state = S2;
				else
					next_state = IDLE;
			end
			S2: begin
				if (in)
					next_state = S3;
				else
					next_state = IDLE;
			end
			S3: begin
				if (in)
					next_state = S4;
				else
					next_state = IDLE;
			end
			S4: begin
				if (in)
					next_state = S5;
				else
					next_state = IDLE;
			end
			S5: begin
				if (in)
					next_state = S6;
				else
					next_state = IDLE;
			end
			S6: begin
				if (in)
					next_state = ERROR;
				else
					next_state = IDLE;
			end
			ERROR: begin
				if (in)
					next_state = ERROR;
				else
					next_state = IDLE;
			end
			default: next_state = IDLE;
		endcase
	end

	// FSM output logic
	always @(posedge clk) begin
		if (reset) begin
			disc <= 0;
			flag <= 0;
			err <= 0;
		end
		else begin
			disc <= 0;
			flag <= 0;
			err <= 0;
			case (state)
				S5: begin
					if (!in)
						disc <= 1;
				end
				S6: begin
					if (in) begin
						flag <= 1;
					end
				end
				ERROR: begin
					err <= 1;
				end
			endcase
		end
	end
endmodule
