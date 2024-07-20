module top_module (
	input clk,
	input in,
	input reset,
	output [7:0] out_byte,
	output done
);

	// State Definitions
	typedef enum logic [2:0] {
		IDLE,
		CHECK_START_BIT,
		RECEIVE_DATA_BITS,
		CHECK_STOP_BIT
	} state_t;

	// Signal Definitions
	logic [2:0] current_state;
	logic [7:0] data_bits;
	logic [2:0] data_counter;

	// FSM
	always_ff @(posedge clk or posedge reset) begin
		if (reset) begin
			current_state <= IDLE;
			data_bits <= 8'b0;
			data_counter <= 3'b0;
			out_byte <= 8'b0;
			done <= 0;
		end else begin
			case (current_state)
				IDLE:
					if (in == 1'b0) begin
						current_state <= CHECK_START_BIT;
						data_bits <= 8'b0;
						data_counter <= 3'b0;
						out_byte <= 8'b0;
						done <= 0;
					end else begin
						current_state <= IDLE;
						out_byte <= 8'b0;
						done <= 0;
					end
					
				CHECK_START_BIT:
					if (in == 1'b0) begin
						current_state <= RECEIVE_DATA_BITS;
						data_bits <= {data_bits[6:0], in};
						data_counter <= data_counter + 1'b1;
					end else begin
						current_state <= IDLE;
						out_byte <= 8'b0;
						done <= 0;
					end
					
				RECEIVE_DATA_BITS:
					if (data_counter == 8) begin
						current_state <= CHECK_STOP_BIT;
						data_counter <= 3'b0;
					end else begin
						current_state <= RECEIVE_DATA_BITS;
						data_bits <= {data_bits[6:0], in};
						data_counter <= data_counter + 1'b1;
					end
					
				CHECK_STOP_BIT:
					if (in == 1'b1) begin
						current_state <= IDLE;
						out_byte <= data_bits[7:0];
						done <= 1'b1;
					end else begin
						current_state <= CHECK_STOP_BIT;
						data_counter <= data_counter + 1'b1;
					end
			endcase
		end
	end
endmodule
