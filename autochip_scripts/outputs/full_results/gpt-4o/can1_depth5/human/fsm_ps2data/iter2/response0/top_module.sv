module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg [23:0] out_bytes,
	output reg done
);

	// Define states
	typedef enum reg [1:0] {
		WAIT_FOR_FIRST_BYTE = 2'b00,
		READ_SECOND_BYTE    = 2'b01,
		READ_THIRD_BYTE     = 2'b10,
		DONE_STATE          = 2'b11
	} state_t;
	
	state_t current_state, next_state;

	// 24-bit message register 
	reg [23:0] message;

	// State transition
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			current_state <= WAIT_FOR_FIRST_BYTE;
		end else begin
			current_state <= next_state;
		end
	end

	// Next state logic
	always @(*) begin
		case (current_state)
			WAIT_FOR_FIRST_BYTE: 
				if (in[3] == 1'b1) 
					next_state = READ_SECOND_BYTE;
				else 
					next_state = WAIT_FOR_FIRST_BYTE;

			READ_SECOND_BYTE:
				next_state = READ_THIRD_BYTE;

			READ_THIRD_BYTE:
				next_state = DONE_STATE;

			DONE_STATE:
				next_state = WAIT_FOR_FIRST_BYTE;

			default:
				next_state = WAIT_FOR_FIRST_BYTE;
		endcase
	end

	// Output logic and message capture
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			out_bytes <= 24'b0;
			done <= 1'b0;
			message <= 24'b0;
		end else begin
			case (current_state)
				WAIT_FOR_FIRST_BYTE: begin
					done <= 1'b0;
					// Capture first byte if in[3] is 1
					if (in[3] == 1'b1)
						message[23:16] <= in;
				end

				READ_SECOND_BYTE: begin
					// Capture second byte
					message[15:8] <= in;
				end

				READ_THIRD_BYTE: begin
					// Capture third byte
					message[7:0] <= in;
				end

				DONE_STATE: begin
					out_bytes <= message;
					done <= 1'b1;
				end
			endcase
			
			// Reset done flag after done state
			if (current_state == DONE_STATE && next_state != DONE_STATE) begin
				done <= 1'b0;
			end
		end
	end

endmodule
