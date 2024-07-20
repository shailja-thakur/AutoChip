module top_module (
	input clk,
	input in,
	input reset,
	output reg done
);
	// Define the states
	typedef enum reg [3:0] {
		IDLE,
		START,
		BIT0,
		BIT1,
		BIT2,
		BIT3,
		BIT4,
		BIT5,
		BIT6,
		BIT7,
		STOP
	} state_t;

	state_t current_state, next_state;
	reg [7:0] data_bits;
	reg [3:0] bit_count;

	// State transition logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			current_state <= IDLE;
			bit_count <= 0;
			done <= 0;
		end else begin
			current_state <= next_state;
		end
	end

	// Next state logic
	always @(*) begin
		done = 0;
		case (current_state)
			IDLE: begin
				if (in == 1'b0)  // Detect start bit
					next_state = START;
				else
					next_state = IDLE;
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
				if (in == 1'b1) begin
					done = 1;
					next_state = IDLE;
				end else
					next_state = IDLE;  // Waits for idle state before finding the next start bit.
			end
			default: next_state = IDLE;
		endcase
	end

	// Count the bits and store data bits
	always @(posedge clk) begin
		if (current_state == IDLE || reset) begin
			bit_count <= 0;
		end else if (current_state >= BIT0 && current_state <= BIT7) begin
			data_bits[bit_count] <= in;
			bit_count <= bit_count + 1;
		end
	end

endmodule
