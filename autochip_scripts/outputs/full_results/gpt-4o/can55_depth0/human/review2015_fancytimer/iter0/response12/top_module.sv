module top_module(
	input wire clk,
	input wire reset,
	input wire data,
	output reg [3:0] count,
	output reg counting,
	output reg done,
	input wire ack );

	// State definitions
	typedef enum reg [2:0] {
		IDLE = 3'b000,
		DETECT = 3'b001,
		LOAD_DELAY = 3'b010,
		COUNT = 3'b011,
		DONE = 3'b100
	} state_t;

	// State registers
	reg [2:0] state, next_state;

	// Pattern detection
	reg [3:0] shift_reg;
	reg [3:0] delay;
	reg [15:0] counter;
	reg [3:0] next_count;

	// Update state and registers
	always @(posedge clk) begin
		if (reset) begin
			state <= IDLE;
			counting <= 1'b0;
			done <= 1'b0;
			shift_reg <= 4'b0000;
			delay <= 4'b0000;
			counter <= 16'b0;
			count <= 4'b0000;
		end else begin
			state <= next_state;
			
			// Shift register for pattern detection
			if (state == IDLE || state == DETECT) begin
				shift_reg <= {shift_reg[2:0], data};
			end

			// Load delay
			if (state == LOAD_DELAY) begin
				delay <= {delay[2:0], data};
			end

			// Update counter and counting state
			if (state == COUNT) begin
				if (counter == 16'd999) begin
					counter <= 16'd0;
					count <= count - 1;
				end else begin
					counter <= counter + 1;
				end

				if (count == 4'd0 && counter == 16'd999) begin
					counting <= 1'b0;
					done <= 1'b1;
				end else begin
					counting <= 1'b1;
				end
			end else begin
				counter <= 16'd0;
			end

			// Set next count value
			if (state == LOAD_DELAY) begin
				count <= {delay[2:0], data};
			end
		end
	end

	// Determine next state
	always @(*) begin
		case (state)
			IDLE: begin
				if (shift_reg == 4'b1101) begin
					next_state = LOAD_DELAY;
				end else begin
					next_state = DETECT;
				end
			end
			DETECT: begin
				if (shift_reg == 4'b1101) begin
					next_state = LOAD_DELAY;
				end else begin
					next_state = DETECT;
				end
			end
			LOAD_DELAY: begin
				if (shift_reg[3:0] == delay) begin
					next_state = COUNT;
				end else begin
					next_state = LOAD_DELAY;
				end
			end
			COUNT: begin
				if (count == 4'b0000 && counter == 16'd999) begin
					next_state = DONE;
				end else begin
					next_state = COUNT;
				end
			end
			DONE: begin
				if (ack) begin
					next_state = IDLE;
				end else begin
					next_state = DONE;
				end
			end
			default: next_state = IDLE;
		endcase
	end

endmodule
