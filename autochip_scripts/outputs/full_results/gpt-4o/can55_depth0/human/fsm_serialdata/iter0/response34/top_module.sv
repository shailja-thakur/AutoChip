module top_module (
	input clk,
	input in,
	input reset,
	output reg [7:0] out_byte,
	output reg done
);

	// State Encoding
	typedef enum reg [2:0] {
		IDLE = 3'b000,
		START_BIT = 3'b001,
		DATA_BIT = 3'b010,
		STOP_BIT = 3'b011,
		ERROR = 3'b100
	} state_t;

	state_t state, next_state;
	reg [3:0] bit_count; // counts the data bits received
	reg [7:0] data_byte; // stores the received data byte

	// State Transition
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= IDLE;
			bit_count <= 4'b0000;
			out_byte <= 8'b0;
			data_byte <= 8'b0;
			done <= 1'b0;
		end else begin
			state <= next_state;
			if (state == IDLE || state == STOP_BIT || state == ERROR) begin
				bit_count <= 4'b0000;
			end else if (state == DATA_BIT) begin
				bit_count <= bit_count + 1;
			end
			
			if (state == DATA_BIT) begin
				data_byte[bit_count] <= in;
			end else if (state == STOP_BIT && next_state == IDLE) begin
				out_byte <= data_byte;
			end
			
			if (state == STOP_BIT && next_state == IDLE) begin
				done <= 1'b1;
			end else begin
				done <= 1'b0;
			end
		end
	end

	// State Logic
	always @(*) begin
		next_state = state;
		case (state)
			IDLE: begin
				if (in == 1'b0) begin // Detect start bit
					next_state = START_BIT;
				end
			end
			START_BIT: begin
				next_state = DATA_BIT;
			end
			DATA_BIT: begin
				if (bit_count < 4'd7) begin
					next_state = DATA_BIT;
				end else begin
					next_state = STOP_BIT;
				end
			end
			STOP_BIT: begin
				if (in == 1'b1) begin // Detect stop bit
					next_state = IDLE;
				end else begin
					next_state = ERROR;
				end
			end
			ERROR: begin
				if (in == 1'b1) begin // Wait for stop bit
					next_state = IDLE;
				end
			end
			default: begin
				next_state = IDLE;
			end
		endcase
	end
endmodule
