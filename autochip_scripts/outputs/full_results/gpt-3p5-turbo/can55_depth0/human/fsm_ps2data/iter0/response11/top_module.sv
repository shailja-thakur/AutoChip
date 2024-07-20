module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);
	reg [23:0] message; // Holds the current message
	reg [1:0] state; // FSM state
	reg [7:0] byte_count; // Counts the received bytes in a message

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 2'b00; // Reset state
			message <= 24'b0; // Reset message
			byte_count <= 8'b0; // Reset byte count
			done <= 1'b0; // Reset done signal
		end else begin
			case(state)
				2'b00: begin // Waiting for byte with in[3] = 1
					if (in[3]) begin
						byte_count <= 8'b0; // Reset the byte count
						message <= {message[15:0], in}; // Shift in the received byte
						state <= 2'b01; // Move to state 2
					end
				end
				2'b01: begin // Receiving message bytes
					byte_count <= byte_count + 1; // Increment the byte count
					message <= {message[15:0], in}; // Shift in the received byte
					if (byte_count == 8'b10) begin
						state <= 2'b10; // Move to state 3
					end
				end
				2'b10: begin // Outputting message and resetting
					out_bytes <= message;
					done <= 1'b1; // Assert the done signal in the next cycle
					state <= 2'b00; // Move back to state 1
				end
				default: state <= 2'b00; // Default state
			endcase
		end
	end
endmodule
