module top_module (
	input clk,
	input in,
	input reset,
	output reg done
);

	// Declare state parameters
	localparam IDLE       = 3'b000;
	localparam START_BIT  = 3'b001;
	localparam DATA_BITS  = 3'b010;
	localparam STOP_BIT   = 3'b011;
	localparam ERROR      = 3'b100;

	// Internal registers
	reg [2:0] current_state, next_state;
	reg [2:0] bit_count;
	reg [7:0] data_byte;

	// State transition logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			current_state <= IDLE;
			bit_count <= 0;
			data_byte <= 0;
			done <= 0;
		end else begin
			current_state <= next_state;
			
			if (current_state == DATA_BITS) begin
				bit_count <= bit_count + 1;
				data_byte <= {in, data_byte[7:1]}; // Shift in the new bit
			end else begin
				bit_count <= 0;
				data_byte <= 0;
			end
		end
	end

	// Next state logic
	always @(*) begin
		next_state = current_state;
		done = 0;

		case(current_state)
			IDLE: begin
				if (in == 0) begin // Detect start bit
					next_state = START_BIT;
				end
			end
			START_BIT: begin
				next_state = DATA_BITS; // Move to data bits state
			end
			DATA_BITS: begin
				if (bit_count == 7) begin // All 8 bits received
					next_state = STOP_BIT;
				end
			end
			STOP_BIT: begin
				if (in == 1) begin // Stop bit detected
					done = 1;
					next_state = IDLE;
				end else begin
					next_state = ERROR;
				end
			end
			ERROR: begin
				if (in == 1) begin // Wait until the line is idle (stop bit detected)
					next_state = IDLE;
				end
			end
		endcase
	end

endmodule
