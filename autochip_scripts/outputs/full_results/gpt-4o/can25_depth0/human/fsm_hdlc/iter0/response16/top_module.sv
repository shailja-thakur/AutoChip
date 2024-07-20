module top_module (
	input clk,
	input reset,
	input in,
	output reg disc,
	output reg flag,
	output reg err);

	reg [2:0] state, next_state;

	// State encoding
	localparam [2:0] 
		IDLE      = 3'b000,
		ONE       = 3'b001,
		TWO       = 3'b010,
		THREE     = 3'b011,
		FOUR      = 3'b100,
		FIVE      = 3'b101,
		SIX       = 3'b110,
		SEVEN     = 3'b111;

	// State transition logic
	always @(*) begin
		case (state)
			IDLE:   next_state = in ? ONE : IDLE;
			ONE:    next_state = in ? TWO : IDLE;
			TWO:    next_state = in ? THREE : IDLE;
			THREE:  next_state = in ? FOUR : IDLE;
			FOUR:   next_state = in ? FIVE : IDLE;
			FIVE:   next_state = in ? SIX : IDLE;         // 5 consecutive 1's
			SIX:    next_state = in ? SEVEN : IDLE;       // 6 consecutive 1's
			SEVEN:  next_state = in ? SEVEN : IDLE;       // Error state, remains in error on more consecutive 1's
			default:next_state = IDLE;
		endcase
	end

	// State flip-flops with synchronous reset
	always @(posedge clk) begin
		if (reset)
			state <= IDLE;
		else
			state <= next_state;
	end

	// Output logic
	always @(posedge clk) begin
		if (reset) begin
			disc <= 0;
			flag <= 0;
			err <= 0;
		end else begin
			case (next_state)
				FIVE:   disc <= ~in;              // discard a bit after 5 consecutive 1s if the next bit is 0
				SIX:    flag <= in;               // flag if it's full 01111110
				SEVEN:  err <= in;                // error if it's 01111111
				default: begin
					disc <= 0;
					flag <= 0;
					err <= 0;
				end
			endcase
		end
	end

endmodule
