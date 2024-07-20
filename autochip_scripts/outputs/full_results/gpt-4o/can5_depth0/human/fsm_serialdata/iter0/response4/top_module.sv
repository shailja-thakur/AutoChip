module top_module (
	input clk,
	input in,
	input reset,
	output reg [7:0] out_byte,
	output reg done
);

	// State encoding
	typedef enum logic [2:0] {
		IDLE = 3'b000,
		START = 3'b001,
		RECEIVE = 3'b010,
		STOP = 3'b011,
		WAIT_STOP = 3'b100
	} state_t;

	// State register
	reg [2:0] state, next_state;
	reg [2:0] bit_counter;
	reg [7:0] byte_data;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= IDLE;
			out_byte <= 8'b0;
			done <= 1'b0;
		end else begin
			state <= next_state;
			if (state == RECEIVE) begin
				byte_data[bit_counter] <= in;
				bit_counter <= bit_counter + 1;
			end else if (state == STOP) begin
				out_byte <= byte_data;
			end
		end
	end

	always @(*) begin
		next_state = state;
		done = 1'b0;
		case (state)
			IDLE: begin
				if (!in) // Start bit detected (logic 0)
					next_state = START;
			end

			START: begin
				if (in == 1'b0) // Confirm still in start bit
					next_state = RECEIVE;
			end
				
			RECEIVE: begin
				if (bit_counter == 3'd7)
					next_state = STOP;
			end

			STOP: begin
				if (in == 1'b1) begin // Stop bit is 1
					done = 1'b1;
					next_state = IDLE;
				end else // Wait until a valid stop bit is found
					next_state = WAIT_STOP;
			end

			WAIT_STOP: begin
				if (in == 1'b1)
					next_state = IDLE;
			end
		endcase
	end

	// Reset bit counter when not in RECEIVE state
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			bit_counter <= 3'b0;
		end else if (state != RECEIVE) begin
			bit_counter <= 3'b0;
		end
	end

endmodule
