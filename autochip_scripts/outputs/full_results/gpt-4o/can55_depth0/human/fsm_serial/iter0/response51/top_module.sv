module top_module (
	input clk,
	input in,
	input reset,
	output reg done
);

	// State encoding
	typedef enum reg [2:0] {
		IDLE    = 3'b000,
		START   = 3'b001,
		DATA    = 3'b010,
		STOP    = 3'b011,
		ERROR   = 3'b100
	} state_t;
	
	state_t current_state, next_state;
	reg [2:0] bit_count;
	reg [7:0] shift_reg;

	// State transition always block
	always @(posedge clk or posedge reset) begin
		if (reset)
			current_state <= IDLE;
		else
			current_state <= next_state;
	end

	// Next state logic and output logic
	always @(*) begin
		next_state = current_state;
		done = 1'b0;
		
		case (current_state)
			IDLE: begin
				if (in == 1'b0) // Start bit detected
					next_state = START;
			end

			START: begin
				next_state = DATA;
				bit_count = 3'b000;
			end

			DATA: begin
				if (bit_count == 3'b111) // Last data bit received
					next_state = STOP;
				else
					next_state = DATA;
			end

			STOP: begin
				if (in == 1'b1) begin // Stop bit detected
					done = 1'b1;
					next_state = IDLE;
				end else
					next_state = ERROR;
			end

			ERROR: begin
				if (in == 1'b1) // Wait for stop bit
					next_state = IDLE;
			end

			default: next_state = IDLE;
		endcase
	end

	// Shift register and bit count logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			shift_reg <= 8'b0;
			bit_count <= 3'b000;
		end else if (current_state == DATA) begin
			shift_reg <= {in, shift_reg[7:1]};
			bit_count <= bit_count + 1;
		end
	end

endmodule
