module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output [23:0] out_bytes,
    output done
);

	reg [7:0] byte_1; // First byte of message
	reg [7:0] byte_2; // Second byte of message
	reg [7:0] byte_3; // Third byte of message
	reg [2:0] state; // State variable
	reg [23:0] out_bytes_reg; // Output register for out_bytes
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 0; // Reset state
		end else begin
			case(state)
				0: begin // Idle state
					if (in[3] == 1) begin // Check for message start
						state <= 1;
						byte_1 <= in; // Store first byte
					end
				end
				1: begin // First byte received
					state <= 2;
					byte_2 <= in; // Store second byte
				end
				2: begin // Second byte received
					state <= 3;
					byte_3 <= in; // Store third byte
				end
				3: begin // Third byte received
					state <= 0;
					out_bytes_reg <= {byte_1, byte_2, byte_3};
				end
			endcase
		end
	end

	// Done signal is asserted in the cycle immediately after the third byte of each message was successfully received
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			done <= 0; // Reset done signal
		end else begin
			done <= (state == 3);
		end
	end
	
	// Output assignment
	assign out_bytes = done ? out_bytes_reg : 24'hxxxxxx;

endmodule
