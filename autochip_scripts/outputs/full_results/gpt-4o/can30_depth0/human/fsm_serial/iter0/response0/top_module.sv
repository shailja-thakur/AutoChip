module top_module (
	input clk,
	input in,
	input reset,
	output reg done
);

	// State encoding
	typedef enum reg [3:0] {
		IDLE     = 4'd0,
		START    = 4'd1,
		BIT0     = 4'd2,
		BIT1     = 4'd3,
		BIT2     = 4'd4,
		BIT3     = 4'd5,
		BIT4     = 4'd6,
		BIT5     = 4'd7,
		BIT6     = 4'd8,
		BIT7     = 4'd9,
		STOP     = 4'd10
	} state_t;

	state_t state, next_state;

	// FSM state transitions
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= IDLE;
		else
			state <= next_state;
		end

	// FSM next state logic
	always @(*) begin
		done = 1'b0; // Default assignment
		next_state = state; // Default assignment
		case(state)
			IDLE: begin
				if (in == 1'b0) // Start bit detected
					next_state = START;
			end
			START: begin
				next_state = BIT0;
			end
			BIT0: begin
				next_state = BIT1;
			end
			BIT1: begin
				next_state = BIT2;
			end
			BIT2: begin
				next_state = BIT3;
			end
			BIT3: begin
				next_state = BIT4;
			end
			BIT4: begin
				next_state = BIT5;
			end
			BIT5: begin
				next_state = BIT6;
			end
			BIT6: begin
				next_state = BIT7;
			end
			BIT7: begin
				next_state = STOP;
			end
			STOP: begin
				if (in == 1'b1) begin // Stop bit correct
					done = 1'b1;
					next_state = IDLE;
				end else begin // Invalid stop bit; wait for idle
					next_state = IDLE;
				end
			end
			default: begin
				next_state = IDLE;
			end
		endcase
	end
endmodule
