module top_module (
	input clk,
	input in,
	input reset,
	output [7:0] out_byte,
	output done
);

// Define states
typedef enum logic [2:0] {
	IDLE,
	START_BIT,
	DATA_BITS,
	STOP_BIT
} state_t;

// Define signal to hold current state
reg [2:0] current_state;

// Define signal to hold current data bits
reg [7:0] current_data;

// Define signal to hold received data byte
reg [7:0] received_byte;

// Define signal to check for start bit
reg start_bit_detected;

// Define signal to check for stop bit
reg stop_bit_detected;

// Initialize signals
initial begin
	current_state = IDLE;
	current_data = 8'b0;
	received_byte = 8'b0;
	start_bit_detected = 0;
	stop_bit_detected = 0;
end

// Synchronous reset
always @(posedge clk) begin
	if (reset) begin
		current_state <= IDLE;
		current_data <= 8'b0;
		received_byte <= 8'b0;
		start_bit_detected <= 0;
		stop_bit_detected <= 0;
	end else begin
		case (current_state)
			IDLE:
				if (in == 1'b0) begin
					start_bit_detected <= 1;
					current_state <= START_BIT;
				end else begin
					start_bit_detected <= 0;
					current_state <= IDLE;
				end
			START_BIT:
				start_bit_detected <= 0;
				current_state <= DATA_BITS;
			DATA_BITS:
				current_data <= {in, current_data[7:1]};
				if (stop_bit_detected == 1) begin
					received_byte <= current_data;
					current_state <= IDLE;
				end else begin
					if (current_data[0] == 1) begin
						stop_bit_detected <= 1;
					end else begin
						stop_bit_detected <= 0;
					end
					current_state <= DATA_BITS;
				end
			STOP_BIT:
				stop_bit_detected <= 0;
				current_state <= IDLE;
		endcase
	end
end

// Assign output signals
assign out_byte = received_byte;
assign done = (current_state == IDLE && stop_bit_detected == 1);

endmodule
