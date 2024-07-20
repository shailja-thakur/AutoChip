module top_module(
	input wire clk,
	input wire reset,
	input wire data,
	output reg [3:0] count,
	output reg counting,
	output reg done,
	input wire ack );

	// State declaration
	typedef enum reg [2:0] {
		IDLE,
		SEARCH,
		LOAD_DELAY,
		COUNTING,
		DONE
	} state_t;
	
	state_t state, next_state;
	reg [7:0] shift_reg;
	reg [3:0] delay, delay_counter;
	reg [13:0] cycle_counter;

	// Sequential logic for State Transition
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= IDLE;
		end else begin
			state <= next_state;
		end
	end

	// Logic for next state and output control
	always @(*) begin
		next_state = state;
		counting = 0;
		done = 0;
		case (state)
			IDLE: begin
				if (reset) begin
					next_state = SEARCH;
					shift_reg = 8'b0;
				end
			end
			
			SEARCH: begin
				shift_reg = {shift_reg[6:0], data};
				if (shift_reg[7:4] == 4'b1101) begin
					next_state = LOAD_DELAY;
				end
			end
			
			LOAD_DELAY: begin
				shift_reg = {shift_reg[6:0], data};
				if (shift_reg[7:4] == 4'b1101) begin
					delay = shift_reg[3:0];
					next_state = COUNTING;
				end
			end
			
			COUNTING: begin
				counting = 1;
				if (cycle_counter == 14'd9999) begin
					cycle_counter = 14'b0;
					if (delay_counter == 4'b0000) begin
						next_state = DONE;
					end else begin
						delay_counter = delay_counter - 4'b0001;
					end
				end
			end
			
			DONE: begin
				done = 1;
				if (ack) begin
					next_state = SEARCH;
					shift_reg = 8'b0;
				end
			end
			
		endcase
	end

	// Sequential logic for cycle_counter and other counter operations
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			cycle_counter <= 14'b0;
			delay_counter <= 4'b0;
		end else begin
			case (state)
				COUNTING: begin
					count = delay_counter;
					cycle_counter = cycle_counter + 14'd1;
				end
				DONE: begin
					cycle_counter = 14'b0;
					delay_counter = delay;
				end
				default: begin
					cycle_counter = 14'b0;
					delay_counter = delay;
				end
			endcase
		end
	end

endmodule
