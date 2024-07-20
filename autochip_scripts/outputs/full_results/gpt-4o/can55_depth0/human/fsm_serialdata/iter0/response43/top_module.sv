module top_module (
	input clk,
	input in,
	input reset,
	output reg [7:0] out_byte,
	output reg done
);

	// FSM states
	typedef enum reg [2:0] {
		IDLE,
		START,
		RECEIVE,
		STOP,
		WAIT_IDLE
	} state_t;
	state_t state, next_state;
	
	reg [2:0] bit_index; // Counter for the 8 data bits
	reg [7:0] data;      // Temporary storage for received data byte
	
	// Synchronous state transition
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= IDLE;
		else
			state <= next_state;
	end
	
	// Output logic: default values
	always @(*) begin
		done = 0;
		case (state)
			IDLE, START: begin
				out_byte = 8'b0;
			end
			RECEIVE: begin
				out_byte = 8'b0;
			end
			STOP: begin
				out_byte = data;
				done = 1;
			end
			WAIT_IDLE: begin
				out_byte = 8'b0;
			end
		endcase
	end
	
	// Next state logic
	always @(*) begin
		next_state = state;
		case (state)
			IDLE: begin
				if (in == 0)
					next_state = START;
			end
			START: begin
				next_state = in ? IDLE : RECEIVE;
			end
			RECEIVE: begin
				if (bit_index == 3'd7)
					next_state = STOP;
			end
			STOP: begin
				if (in == 1)
					next_state = WAIT_IDLE;
				else
					next_state = IDLE;
			end
			WAIT_IDLE: begin
				if (in == 1)
					next_state = IDLE;
			end
		endcase
	end
	
	// Data reception and bit index increment
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			bit_index <= 0;
			data <= 0;
		end
		else begin
			case (state)
				IDLE, START: begin
					bit_index <= 0;
					data <= 0;
				end
				RECEIVE: begin
					data[bit_index] <= in;
					bit_index <= bit_index + 1;
				end
				STOP, WAIT_IDLE: begin
					// Do nothing, wait for state change
				end
			endcase
		end
	end
endmodule
