module top_module (
	input clk,
	input in,
	input reset,
	output [7:0] out_byte,
	output done
);

	// Define the states
	typedef enum logic [2:0] {
		IDLE,
		START_BIT,
		DATA_BITS,
		STOP_BIT
	} state_t;

	reg state_t current_state, next_state;
	reg [7:0] received_byte;
	reg [2:0] bit_count;
	reg start_detected, stop_detected;
	wire idle_next, start_bit_next, data_bits_next, stop_bit_next;
	wire [7:0] data;

	always_ff @(posedge clk, posedge reset) begin
		if (reset)
			current_state <= IDLE;
		else
			current_state <= next_state;
	end

	always_comb begin
		idle_next = (current_state == IDLE) ? 1'b1 : 1'b0;
		start_bit_next = (current_state == START_BIT) ? 1'b1 : 1'b0;
		data_bits_next = (current_state == DATA_BITS) ? 1'b1 : 1'b0;
		stop_bit_next = (current_state == STOP_BIT) ? 1'b1 : 1'b0;
	end

	always_comb begin
		out_byte = received_byte;
		done = (current_state == STOP_BIT) ? 1'b1 : 1'b0;
	end

	always_ff @(posedge clk) begin
		if (reset) begin
			next_state <= IDLE;
			bit_count <= 3'b0;
			start_detected <= 1'b0;
			stop_detected <= 1'b0;
			received_byte <= 8'b0;
		end else begin
			case (current_state)
				IDLE: begin
					if (!in)
						next_state <= START_BIT;
					else
						next_state <= IDLE;
				end
				START_BIT: begin
					if (in)
						next_state <= DATA_BITS;
					else
						next_state <= IDLE;
				end
				DATA_BITS: begin
					if (bit_count == 3'b000) begin
						received_byte <= {in, received_byte[7:1]};
						bit_count <= bit_count + 1;
						next_state <= DATA_BITS;
					end else if (bit_count == 3'b111) begin
						next_state <= STOP_BIT;
						bit_count <= 3'b0;
					end else begin
						received_byte <= {in, received_byte[7:1]};
						bit_count <= bit_count + 1;
						next_state <= DATA_BITS;
					end
				end
				STOP_BIT: begin
					if (in)
						next_state <= IDLE;
					else
						next_state <= STOP_BIT;
				end
			endcase
		end
	end

endmodule
