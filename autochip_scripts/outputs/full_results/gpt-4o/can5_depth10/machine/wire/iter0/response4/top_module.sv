module top_module(
	input wire clk,        // Clock input
	input wire reset,      // Reset input
	output reg [7:0] data_out,  // Data output
	output reg valid_out   // Valid output
);

	// State encoding
	typedef enum reg [1:0] {
		IDLE = 2'b00,
		WAIT = 2'b01,
		PROCESS = 2'b10,
		DONE = 2'b11
	} state_t;

	state_t state, next_state;
	reg [3:0] counter; // 4-bit counter

	// State transition logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= IDLE;
			counter <= 4'b0000;
			data_out <= 8'b00000000;
			valid_out <= 1'b0;
		end else begin
			state <= next_state;
			
			// Counter logic
			if (state == WAIT)
				counter <= counter + 1;
			else
				counter <= 4'b0000;

			// Data output and valid output logic
			case (state)
				IDLE: begin
					data_out <= 8'b00000000;
					valid_out <= 1'b0;
				end
				WAIT: begin
					data_out <= 8'b00000000;
				end
				PROCESS: begin
					data_out <= 8'hFF; // Example of processed data
				end
				DONE: begin
					valid_out <= 1'b1;
				end
			endcase
		end
	end

	// Next state logic
	always @(*) begin
		case (state)
			IDLE: begin
				if (reset)
					next_state = IDLE;
				else
					next_state = WAIT;
			end
			WAIT: begin
				if (counter == 4'b1111) // Example threshold for counter
					next_state = PROCESS;
				else
					next_state = WAIT;
			end
			PROCESS: begin
				next_state = DONE;
			end
			DONE: begin
				next_state = IDLE;
			end
			default: begin
				next_state = IDLE;
			end
		endcase
	end

endmodule
