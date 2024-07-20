module top_module(
	input clk,
	input reset,
	input data,
	output reg shift_ena,
	output reg counting,
	input done_counting,
	output reg done,
	input ack );

	// State declaration
	typedef enum reg [2:0] {
		S_IDLE,
		S_DETECT1,
		S_DETECT11,
		S_DETECT110,
		S_DETECT1101,
		S_SHIFT,
		S_COUNT,
		S_DONE
	} state_t;
	state_t state, next_state;
	
	// Pattern detection
	reg [3:0] pattern;
	
	// Sequential state transition
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= S_IDLE;
		else
			state <= next_state;
	end
	
	// State transition logic
	always @(*) begin
		case (state)
			S_IDLE: begin
				if (data == 1'b1)
					next_state = S_DETECT1;
				else
					next_state = S_IDLE;
			end
			S_DETECT1: begin
				if (data == 1'b1)
					next_state = S_DETECT11;
				else
					next_state = S_IDLE;
			end
			S_DETECT11: begin
				if (data == 1'b0)
					next_state = S_DETECT110;
				else
					next_state = S_IDLE;
			end
			S_DETECT110: begin
				if (data == 1'b1)
					next_state = S_DETECT1101;
				else
					next_state = S_IDLE;
			end
			S_DETECT1101: begin
				next_state = S_SHIFT;
			end
			S_SHIFT: begin
				if (pattern == 4'd4)  // After 4 clock cycles
					next_state = S_COUNT;
				else
					next_state = S_SHIFT;
			end
			S_COUNT: begin
				if (done_counting)
					next_state = S_DONE;
				else
					next_state = S_COUNT;
			end
			S_DONE: begin
				if (ack)
					next_state = S_IDLE;
				else
					next_state = S_DONE;
			end
			default: next_state = S_IDLE;
		endcase
	end
	
	// State output logic and pattern counter
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			shift_ena <= 1'b0;
			counting <= 1'b0;
			done <= 1'b0;
			pattern <= 4'd0;
		end
		else begin
			case (state)
				S_IDLE: begin
					shift_ena <= 1'b0;
					counting <= 1'b0;
					done <= 1'b0;
					pattern <= 4'd0;
				end
				S_DETECT1, S_DETECT11, S_DETECT110, S_DETECT1101: begin
					shift_ena <= 1'b0;
					counting <= 1'b0;
					done <= 1'b0;
				end
				S_SHIFT: begin
					shift_ena <= 1'b1;
					counting <= 1'b0;
					done <= 1'b0;
					pattern <= pattern + 1'b1;
				end
				S_COUNT: begin
					shift_ena <= 1'b0;
					counting <= 1'b1;
					done <= 1'b0;
					pattern <= 4'd0;
				end
				S_DONE: begin
					shift_ena <= 1'b0;
					counting <= 1'b0;
					done <= 1'b1;
				end
				default: begin
					shift_ena <= 1'b0;
					counting <= 1'b0;
					done <= 1'b0;
				end
			endcase
		end
	end
endmodule
