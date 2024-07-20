module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg [23:0] out_bytes,
	output reg done
);

	reg [1:0] state, next_state;
	reg [23:0] temp_bytes;

	localparam WAIT = 2'b00,
	           BYTE1 = 2'b01,
	           BYTE2 = 2'b10,
	           BYTE3 = 2'b11;

	// State transition
	always @(posedge clk) begin
		if (reset)
			state <= WAIT;
		else
			state <= next_state;
	end

	// Next state logic
	always @(*) begin
		case (state)
			WAIT: begin
				if (in[3])    // Check if in[3] is 1
					next_state = BYTE1;
				else
					next_state = WAIT;
			end
			BYTE1: next_state = BYTE2;
			BYTE2: next_state = BYTE3;
			BYTE3: next_state = WAIT;
			default: next_state = WAIT;
		endcase
	end

	// Output logic and temp_bytes capturing
	always @(posedge clk) begin
		if (reset) begin
			out_bytes <= 24'b0;
			done <= 1'b0;
			temp_bytes <= 24'b0;
		end else begin
			case (state)
				WAIT: begin
					done <= 1'b0;
				end
				BYTE1: begin
					temp_bytes[23:16] <= in;
				end
				BYTE2: begin
					temp_bytes[15:8] <= in;
				end
				BYTE3: begin
					temp_bytes[7:0] <= in;
					out_bytes <= {temp_bytes[23:8], in};  // Latch the final packet
					done <= 1'b1;  // Signal that a message is received
				end
				default: begin
					done <= 1'b0;
				end
			endcase
		end
	end

endmodule
