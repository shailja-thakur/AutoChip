module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);
	// State definitions
	enum {WAIT_FIRST_BYTE, WAIT_SECOND_BYTE, WAIT_THIRD_BYTE, MESSAGE_RECEIVED} state, next_state;
	
	reg [7:0] byte1, byte2, byte3;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= WAIT_FIRST_BYTE;
			byte1 <= 8'h00;
			byte2 <= 8'h00;
			byte3 <= 8'h00;
			done <= 0;
			out_bytes <= 24'h000000;
		end else begin
			state <= next_state;
			case (state)
				WAIT_FIRST_BYTE:
					if (in[3] == 1) begin
						byte1 <= in;
						next_state <= WAIT_SECOND_BYTE;
					end else begin
						byte1 <= 8'h00;
						done <= 0;
						next_state <= WAIT_FIRST_BYTE;
					end
				WAIT_SECOND_BYTE:
					byte2 <= in;
					next_state <= WAIT_THIRD_BYTE;
				WAIT_THIRD_BYTE:
					byte3 <= in;
					done <= 1;
					next_state <= MESSAGE_RECEIVED;
				MESSAGE_RECEIVED:
					byte1 <= 8'h00;
					byte2 <= 8'h00;
					byte3 <= 8'h00;
					done <= 0;
					out_bytes <= {byte1, byte2, byte3};
					next_state <= WAIT_FIRST_BYTE;
			endcase
		end
	end

endmodule
