module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg done
);
	// State declarations
	parameter IDLE = 2'b00, BYTE1 = 2'b01, BYTE2 = 2'b10, BYTE3 = 2'b11;

	reg [1:0] current_state, next_state;

	// State transition logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			current_state <= IDLE;
		end
		else begin
			current_state <= next_state;
		end
	end

	// Next state and output logic
	always @* begin
		// Default values
		done = 0;
		next_state = current_state;

		case (current_state)
			IDLE: begin
				if (in[3] == 1'b1)
					next_state = BYTE1;
			end
			BYTE1: begin
				next_state = BYTE2;
			end
			BYTE2: begin
				next_state = BYTE3;
			end
			BYTE3: begin
				next_state = IDLE;
				done = 1'b1;
			end
		endcase
	end

endmodule
