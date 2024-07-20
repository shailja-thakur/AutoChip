module top_module (
	input clk,
	input in,
	input reset,
	output done
);
	
	// State definitions
	typedef enum logic [2:0] {
		IDLE,
		START_BIT,
		DATA_BITS,
		STOP_BIT
	} state_t;
	
	// Register declarations
	reg [2:0] current_state;
	reg [7:0] received_data;
	reg [7:0] expected_data;
	reg [2:0] bit_counter;
	reg done;
	
	// Synchronous reset
	always_ff @(posedge clk) begin
		if (reset) begin
			current_state <= IDLE;
			received_data <= 8'h00;
			expected_data <= 8'h00;
			bit_counter <= 3'b0;
		end else begin
			current_state <= next_state;
			received_data <= next_received_data;
			expected_data <= next_expected_data;
			bit_counter <= next_bit_counter;
		end
	end
	
	// Combinational logic
	always_comb begin
		case (current_state)
			IDLE: begin
				if (in == 1'b0) begin
					next_state = START_BIT;
				end else begin
					next_state = IDLE;
				end
				next_received_data = 8'h00;
				next_expected_data = 8'h00;
				next_bit_counter = 3'b0;
			end
			START_BIT: begin
				if (in == 1'b0) begin
					next_state = DATA_BITS;
				end else begin
					next_state = START_BIT;
				end
				next_received_data = 8'h00;
				next_expected_data = 8'h00;
				next_bit_counter = 3'b0;
			end
			DATA_BITS: begin
				if (bit_counter == 3'b0) begin
					next_state = STOP_BIT;
				end else begin
					next_state = DATA_BITS;
				end
				next_received_data = {in, received_data[7:1]};
				next_expected_data = {1'b0, expected_data[7:1]};
				next_bit_counter = bit_counter + 1;
			end
			STOP_BIT: begin
				if (in == 1'b1 && expected_data == 8'hFE) begin
					next_state = IDLE;
					next_received_data = 8'h00;
					next_expected_data = 8'h00;
					next_bit_counter = 3'b0;
					done = 1'b1;
				end else begin
					next_state = STOP_BIT;
					next_received_data = {in, received_data[7:1]};
					next_expected_data = {1'b0, expected_data[7:1]};
					next_bit_counter = bit_counter + 1;
					done = 1'b0;
				end
			end
			default: begin
				next_state = IDLE;
				next_received_data = 8'h00;
				next_expected_data = 8'h00;
				next_bit_counter = 3'b0;
			end
		endcase
	end
	
endmodule
