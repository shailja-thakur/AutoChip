module top_module (
	input clk,
	input reset,
	input in,
	output reg disc,
	output reg flag,
	output reg err);

	// State encoding
	localparam 	IDLE      = 3'b000,
				ONE       = 3'b001,
				TWO       = 3'b010,
				THREE     = 3'b011,
				FOUR      = 3'b100,
				FIVE      = 3'b101,
				SIX       = 3'b110,
				SEVEN     = 3'b111;

	reg [2:0] state, next_state;

	// State transition logic
	always @(posedge clk) begin
		if (reset)
			state <= IDLE;
		else
			state <= next_state;
	end

	// Next state logic
	always @(*) begin
		case(state)
			IDLE:    next_state = in ? ONE : IDLE;
			ONE:     next_state = in ? TWO : IDLE;
			TWO:     next_state = in ? THREE : IDLE;
			THREE:   next_state = in ? FOUR : IDLE;
			FOUR:    next_state = in ? FIVE : IDLE;
			FIVE:    next_state = in ? SIX : IDLE;
			SIX:     next_state = in ? SEVEN : IDLE;
			SEVEN:   next_state = in ? SEVEN : IDLE;
			default: next_state = IDLE;
		endcase
	end

	// Output logic
	always @(posedge clk) begin
		if (reset) begin
			disc <= 0;
			flag <= 0;
			err  <= 0;
		end 
		else begin
			case(state)
				FIVE: begin
					disc <= in ? 1 : 0;  // 0111110 sequence detected
					flag <= 0;
					err  <= 0;
				end
				SIX: begin
					disc <= 0;
					flag <= in ? 1 : 0;  // 01111110 sequence detected
					err  <= 0;
				end
				SEVEN: begin
					disc <= 0;
					flag <= 0;
					err  <= 1;  // 01111111 or more consecutive 1s detected
				end
				default: begin
					disc <= 0;
					flag <= 0;
					err  <= 0;
				end
			endcase
		end
	end

endmodule
