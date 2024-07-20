module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg [23:0] out_bytes,
	output reg done
);

	// Define states
	typedef enum reg [1:0] {
		IDLE            = 2'b00,
		BYTE1_RECEIVED  = 2'b01,
		BYTE2_RECEIVED  = 2'b10
	} state_t;
	
	state_t current_state, next_state;

	// 24-bit message register 
	reg [23:0] message;
	reg [23:0] out_bytes_next;
	reg done_next;

	// State transition
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			current_state <= IDLE;
		end else begin
			current_state <= next_state;
		end
	end

    // Next state logic and message capture
	always @(*) begin
		next_state = current_state;
		out_bytes_next = out_bytes;
		done_next = 1'b0;
		
		case (current_state)
			IDLE: begin
				if (in[3] == 1'b1) begin
					next_state = BYTE1_RECEIVED;
					out_bytes_next[23:16] = in;
				end
			end

			BYTE1_RECEIVED: begin
				next_state = BYTE2_RECEIVED;
				out_bytes_next[15:8] = in;
			end

			BYTE2_RECEIVED: begin
				next_state = IDLE;
				out_bytes_next[7:0] = in;
				done_next = 1'b1;
			end
		endcase
	end

	// Output and state register updates
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			out_bytes <= 24'b0;
			done <= 1'b0;
		end else begin
			out_bytes <= out_bytes_next;
			done <= done_next;
		end
	end

endmodule
