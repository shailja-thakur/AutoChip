module top_module (
	input clk,
	input in,
	input reset,
	output [7:0] out_byte,
	output done
);

	// State definition
	typedef enum logic [2:0] {
		IDLE,
		RECEIVE_START,
		RECEIVE_DATA,
		RECEIVE_STOP
	} state_type;

	// Internal signals
	logic [2:0] state;
	logic [7:0] received_byte;
	logic start_bit_detected;
	logic stop_bit_detected;
	logic [2:0] bit_counter;
	logic [2:0] bit_position;
	
	// FSM behavior
	always_ff @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= IDLE;
			received_byte <= 8'b0;
			start_bit_detected <= 1'b0;
			stop_bit_detected <= 1'b0;
			bit_counter <= 3'b0;
			bit_position <= 3'b0;
		end else begin
			case (state)
				IDLE:
					begin
						if (in == 1'b0) begin
							state <= RECEIVE_START;
							start_bit_detected <= 1'b1;
							stop_bit_detected <= 1'b0;
							bit_counter <= 3'b0;
							bit_position <= 3'b0;
						end else begin
							state <= IDLE;
							start_bit_detected <= 1'b0;
							stop_bit_detected <= 1'b0;
							bit_counter <= 3'b0;
							bit_position <= 3'b0;
						end
					end
				
				RECEIVE_START:
					begin
						state <= RECEIVE_DATA;
						start_bit_detected <= 1'b0;
						stop_bit_detected <= 1'b0;
						bit_counter <= 3'b1;
						bit_position <= 3'b0;
					end
				
				RECEIVE_DATA:
					begin
						if (bit_counter == 3'b100) begin
							state <= RECEIVE_STOP;
							start_bit_detected <= 1'b0;
							stop_bit_detected <= 1'b0;
							bit_counter <= 3'b0;
							bit_position <= 3'b0;
						end else begin
							if (bit_position == 3'b000) begin
								received_byte[bit_counter] <= in;
								bit_counter <= bit_counter + 1;
								bit_position <= bit_position + 1;
							end else begin
								bit_position <= bit_position + 1;
							end
							state <= RECEIVE_DATA;
							start_bit_detected <= 1'b0;
							stop_bit_detected <= 1'b0;
						end
					end
				
				RECEIVE_STOP:
					begin
						if (in == 1'b1) begin
							state <= IDLE;
							start_bit_detected <= 1'b0;
							stop_bit_detected <= 1'b1;
							out_byte <= received_byte;
							done <= 1'b1;
						end else begin
							state <= RECEIVE_STOP;
							start_bit_detected <= 1'b0;
							stop_bit_detected <= 1'b0;
							out_byte <= 8'b0;
							done <= 1'b0;
						end
					end
			endcase
		end
	end

endmodule
